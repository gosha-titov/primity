<img width="1344" height="768" alt="primity_logo" src="https://github.com/user-attachments/assets/8b5c3147-ac38-43cb-9852-178c47507c26" />

# Type-Safe Primitives for Swift

Primity is a library of type-safe Swift primitives that move validation into the type system.

I am not happy with `guard` clauses, failable initializers, and
hand-written `Codable` conformances, because they are procedural and
repetitive. They do their job, but the same "not empty", "not negative",
"sorted" logic is copied into every model, every method, and every test.
Primity is suggesting to do almost exactly the same, but through types.

An invalid value simply cannot exist. `NonEmpty<String>` cannot be empty,
because its only initializer rejects an empty string. `Positive<Int>`
cannot be zero. `Within<`0`, `18`, Int>` cannot be nineteen. There is
nothing to test — like `Hashable`, the guarantee is in the type, not
in your code.

These are the design principles behind Primity:

  1. One invariant per type — each primitive does exactly one thing.
  2. Zero domain knowledge — no business logic, no dependencies.
  3. Compose, don't configure — stack types instead of validation rules.
  4. Fail fast at the boundary — invalid values are rejected at creation.

The library has no dependencies. All you need is this, in `Package.swift`:

```swift
dependencies: [
    .package(
        url: "https://github.com/gosha-titov/primity.git",
        .upToNextMinor(from: "3.0.0")
    )
]
```


## Motivation

This is a traditional model:

```swift
struct User: Sendable {
    let name: String      // should be non-empty and trimmed
    let awards: [Award]   // should be sorted in descending order
    let progress: Double  // should be non-negative

    init?(name: String, awards: [Award], progress: Double) {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty, progress >= 0 else { return nil }
        self.name = name
        self.awards = awards.sorted(by: >)
        self.progress = progress
    }
}
```

Three fields, a wall of logic. And `Codable` is still ahead — auto-synthesis
bypasses your `init`, so you write `init(from:)` by hand. For every model.
You end up testing `guard` statements, not business logic.

Here is its type-oriented alternative:

```swift
struct User: Codable, Sendable {
    let name: Name
    let awards: Awards
    let progress: Progress
}

extension User {
    typealias Name = NonEmpty<Trimmed<String>>
    typealias Awards = Descended<Array<Award>>
    typealias Progress = NonNegative<Double>
}
```

No `guard`. No manual `Codable`. Validation happens once, at creation,
and never again. Methods that accept `User.Name` don't re-check anything —
the type already guarantees correctness.

Client code should not know what is inside `User.Name`. If you change
`NonEmpty<Trimmed<String>>` to `NonEmpty<Collapsed<Trimmed<String>>>`,
call sites stay the same.


## Primitives

There are two kinds of primitives.

**Validators** reject bad input — they throw a descriptive typed error
(and offer an `init?` convenience):

  * `NonEmpty` — the value is not empty.
  * `NonNegative`, `Positive` — numeric bounds.
  * `Within` — the value (or element count) is within bounds.

**Adjusters** always accept and transform:

  * `Trimmed`, `Collapsed`, `Ragged`, `Stripped` — whitespace and decorative symbols.
  * `Capitalized`, `Lowercased`, `Uppercased` — casing.
  * `Sorted` (via `Ascended`, `Descended`) — ordering.
  * `First`, `Last` — keep only the first or last elements or characters.
  * `Clamped` — clamps to a closed range.

Look at the names. Adjusters are participles with _-ed_: they tell you
what has **already been done** to the value. Validators are adjectives:
they tell you the **state** of the value. "Always accepts and fixes"
versus "checks and maybe rejects." You see the difference instantly.
Naming matters.


## Composition

Stack them. Each layer does one thing. Wrappers apply right to left:

```swift
typealias Tag = NonEmpty<Lowercased<First<`32`,Collapsed<Trimmed<Stripped<String>>>>>>

let tag: Tag? = "  Swift   💙 DEVelopment   💻  "
// "swift development"
```

It is equivalent to this chain:

```swift
let tag = string
    .stripped()          // remove decorative symbols
    .trimmed()           // trim edges
    .collapsed()         // collapse multiple spaces into one
    .first(32)           // keep the first 32 characters
    .lowercased()        // convert to lowercase
```

Order matters. If you cut the value first and then collapse spaces,
the result may end up shorter than intended.

A few compositions I use every day:

```swift
typealias Title = NonEmpty<First<`256`, Collapsed<Trimmed<String>>>>

typealias Rating = Clamped<`1`, `5`, Int>

typealias Latitude = Within<`-90.0`, `90.0`, Double>
```

You can also name the bounds once and reuse them:

```swift
typealias TwoThroughTen<Value: Withinable> = Within<`2`, `10`, Value> where Value.Bound == Int

typealias AnswerOption = NonEmpty<First<`32`, Collapsed<Trimmed<String>>>>

typealias AnswerOptions = TwoThroughTen<Array<AnswerOption>>
```


## Literals

Primitives understand literals:

```swift
let string: Trimmed<Stripped<String>> = "hello world"

let array: NonEmpty<Ascended<Array<Int>>>? = [5, 1, 3, 2, 4]

let double: NonNegative<Double>? = 95.97
```

Custom types use `init(expressing:)`, which builds the whole chain at once:

```swift
typealias Paragraph = NonEmpty<Collapsed<Trimmed<RichText>>>

let paragraph = Paragraph(expressing: text)

// Without it you would write:
let paragraph = Paragraph(Collapsed(Trimmed(text)))
```

To get a raw value back:

```swift
let string = Trimmed(Stripped("swift")).asString()

let array = NonEmpty(Ascended([5, 1, 3, 2, 4]))?.asArray()

let double = NonNegative(95.97)?.asDouble()

// Base for all types:
let text = First(Collapsed(richText)).expressed()
```


## Immutable Operations

Every operation returns a new instance. Methods are available
for strings, arrays, dictionaries, sets, and numbers:

```swift
Ascended([5, 2, 1, 4, 3])
    .appending(6)

NonEmpty(["en": "Hello", "fr": "Bonjour"])?
    .setting("Привет", for: "ru")

Trimmed("Jobs")
    .prepending("Steve ")

NonNegative(16.7)?
    .multiplying(by: 9.4)
```

On adjusters these methods always succeed. On validators they re-validate
the result and come in two flavors: `throws`, if you want the typed error,
or an optional, if `nil` is enough.


## Conveniences

`NonEmpty` knows its content is there, so it gives you direct access
without optionals:

```swift
let numbers = try NonEmpty([3, 1, 2])

numbers.first    // 3, not Int?
numbers.last     // 2
numbers.min()    // 1
numbers.max()    // 3
numbers.random() // some element
```

And creates a single-element instance in one call:

```swift
let letters = NonEmpty<String>.single("f")

let numbers = NonEmpty<Array<Int>>.single(10)

let greetings = NonEmpty<Dictionary<String, String>>.single("Hello", for: "en")
```


## Codable

A primitive encodes its inner value directly — no metadata, no `wrapped`
field. JSON stays flat and backward-compatible with the data you already have:

```json
// Encodes and decodes directly:
"swift dev"

// Without this it would be:
{"wrapped":{"wrapped":{"wrapped":{"wrapped":{"wrapped":"swift dev"}}}}}
```

During decoding, the primitive calls its own initializer. If validation
fails, it throws a clear error: `Value must not be empty`,
`Value '19' must be within bounds 0...18`, and so on. Nothing hand-written.


## Validate Once

Here is the real power. It is not about pretty models.

A value created by a primitive can travel through your system freely.
It is already valid. It will stay valid. It cannot become invalid,
because it is immutable.

Before, every method received a `String` and panicked: is it empty?
Are there spaces? Is the array sorted? Check again. And again.
Paranoia as a programming technique.

Now the method takes `User.Name`. The type guarantees correctness.
No `guard` inside. The check happened once, at the boundary. Never again.
Validation disappears not only from models — it disappears from methods,
services, controllers, and all their tests.

What about the tests? Do you test that `Hashable` hashes correctly?
No — that is a guarantee of the language. Same here: `NonEmpty` cannot
hold an empty string, by definition. Testing it in your models is
pointless. Delete those tests. What stays is business logic — and tests
for your own custom primitives, if you write them.


## More Examples

Before and after.

### A poll.

```swift
// Before
struct Poll {
    let options: [String]
    init?(options: [String]) {
        let options = options
            .map { $0.trimmed().collapsed().first(256) }
            .filter { !$0.isEmpty }
        guard (2...10).contains(options.count) else { return nil }
        self.options = options
    }
}
```

```swift
// After
struct Poll {
    let options: Options
}

extension Poll {
    typealias Options = Within<`2`, `10`, Array<Option>>
    typealias Option = NonEmpty<First<`256`, Collapsed<Trimmed<String>>>>
}
```


### A pie chart.

```swift
// Before
struct PieChart {
    let sectors: [Sector]
    init?(sectors: [Sector]) {
        guard !sectors.isEmpty else { return nil }
        self.sectors = sectors
    }
}

extension PieChart {
    struct Sector {
        let value: Int
        let label: String
        init?(value: Int, label: String) {
            let label = label.trimmed().collapsed().first(64)
            guard !label.isEmpty, value > 0 else { return nil }
            self.value = value
            self.label = label
        }
    }
}
```

```swift
// After
struct PieChart {
    let sectors: NonEmpty<Array<Sector>>
}

extension PieChart {
    struct Sector {
        let label: NonEmpty<First<`64`, Collapsed<Trimmed<String>>>>
        let value: Positive<Int>
    }
}
```

### A place.

```swift
// Before
struct Place {
    let name: String
    let address: String?
    let latitude: Double
    let longitude: Double
    init?(name: String, address: String?, latitude: Double, longitude: Double) {
        let name = name.trimmed().collapsed().first(64)
        let address = address?.stripped().trimmed().collapsed().first(256)
        guard !name.isEmpty, (-90...90).contains(latitude), (-180...180).contains(longitude) else { return nil }
        self.name = name
        self.address = if let address, !address.isEmpty { address } else { nil }
        self.latitude = latitude
        self.longitude = longitude
    }
}
```

```swift
// After
struct Place {
    let name: Name
    let address: Address?
    let latitude: Latitude
    let longitude: Longitude
}

extension Place {
    typealias Name = NonEmpty<First<`64`, Collapsed<Trimmed<String>>>>
    typealias Address = NonEmpty<First<`256`, Collapsed<Trimmed<Stripped<String>>>>>
    typealias Latitude = Within<`-90.0`, `90.0`, Double>
    typealias Longitude = Within<`-180.0`, `180.0`, Double>
}
```

### Two remarks.

The "before" examples are already optimistic: they use ready-made methods
like `trimmed()`, `collapsed()`, `stripped()`. Without them the code would
be two or three times longer. And none of those methods implement `Codable`
— you would write it by hand, like at the beginning of this README.

A fat `init?` full of `guard`s also tells you nothing when it returns `nil`.
What broke? Why? Silence. Done properly, you need an error `enum` and
`throws` instead of `nil` — more boilerplate. In the "after" examples you
need nothing: each property validates itself at creation, and the failure
reason is clear immediately.


## Architecture

**A wrapper is just a container.** No bridging protocols, no generated
code — only conditional conformance and default implementations.

**Two protocols, two flavors.**
`AnyWrapping` branches into `Wrapping` (adjusters — initialization always
succeeds) and `MaybeWrapping` (validators — initialization throws on bad
data, with an `init?` convenience). Symmetrically, `AnyExpressible`
branches into `Expressible` and `MaybeExpressible` for creation from raw
values.

**One requirement per wrapper.**
Each primitive asks exactly one protocol from its wrapped value:
`Trimmed` asks for `Trimmable`, `Capitalized` for `Capitalizable`,
`Sorted` for `Sortable`. The wrapper itself does nothing — it merely
forwards the behavior of the wrapped value. In a chain like
`Capitalized<Trimmed<String>>`, each layer adds one constraint, and the
compiler assembles them together.

**Empty-body conformances.**
Every standard protocol has a default implementation that forwards to the
wrapped value. You write `extension Capitalized: Codable where Wrapped: Codable {}`
— empty, no body — and `Capitalized<String>` becomes `Codable` instantly.
`Equatable`, `Hashable`, `Sendable`, `Collection`, `BidirectionalCollection`,
literals — all work the same way.


## Custom Types

Conform your type to the required protocols. That is all:

```swift
extension RichText: Expressible {}

extension RichText: Trimmable {
    func trimmed() -> RichText {...}
}

extension RichText: Collapsible {
    func collapsed() -> RichText {...}
}

extension RichText: Emptyable {
    var isEmpty: Bool {
        return string.isEmpty
    }
}

extension AnyWrapping where Self: AnyExpressible, Expressed == RichText {
    func asRichText() -> RichText {
        return expressed()
    }
}

typealias Bio = NonEmpty<Collapsed<Trimmed<RichText>>>
```


## Custom Primitives

Three steps. No implementation code needed.

First, define the protocol with a default implementation for all wrappers:

```swift
protocol Normalizable {
    func normalized() -> Self
}

extension Wrapping where Wrapped: Normalizable {
    func normalized() -> Self {
        return Self(wrapped.normalized())
    }
}

extension String: Normalizable {
    func normalized() -> String {
        return lowercased()
    }
}
```

Second, create the wrapper:

```swift
struct Normalized<Wrapped: Normalizable>: Wrapping {
    let wrapped: Wrapped
    init(_ value: Wrapped) {
        self.wrapped = value.normalized()
    }
}
```

Third, declare conformances — empty extensions. Primity provides default
implementations for everything; the compiler fills in the rest:

```swift
// Raw-value conversion — required for literals and `expressing`:
extension Normalized: Expressible, AnyExpressible where Wrapped: Expressible {}

// Standard protocols:
extension Normalized: Codable where Wrapped: Codable {}
extension Normalized: Equatable where Wrapped: Equatable {}
extension Normalized: Hashable where Wrapped: Hashable {}
extension Normalized: Sendable where Wrapped: Sendable {}

// Collections:
extension Normalized: Sequence where Wrapped: Sequence {}
extension Normalized: Collection where Wrapped: Collection {}
extension Normalized: BidirectionalCollection where Wrapped: BidirectionalCollection {}

// Compatibility with other primitives:
extension Normalized: Emptyable where Wrapped: Emptyable {}
extension Normalized: Trimmable where Wrapped: Trimmable {}
```

Pick what you need. The rest is automatic.


## Our Types vs. Their Methods

| Primity | Swift Standard Library | Foundation |
| ------ | ------ | ------ |
| `Trimmed` | - | `trimmingCharacters(in:)` |
| `Collapsed` | - | - |
| `Ragged` | - | - |
| `Stripped` | - | - |
| `Capitalized` | - | `capitalized` |
| `Lowercased` | `lowercased()` | - |
| `Uppercased` | `uppercased()` | - |
| `Sorted` / `Ascended` / `Descended` | `sorted(by:)` | - |
| `First` / `Last` | `prefix(_:)` / `suffix(_:)` | - |
| `Clamped` | `min(_:max:)` + `max(_:min:)` | - |
| `NonEmpty` | `isEmpty` + `guard` | - |
| `NonNegative` / `Positive` | `< 0` / `> 0` + `guard` | - |
| `Within` | `ClosedRange.contains(_:)` + `guard` | - |

Their methods transform a value once and forget about it. Our types make
the result impossible to lose: the guarantee travels with the value.


## Performance

A wrapper is a single-field struct. It lives on the stack or inline in its
parent — no extra allocations. `NonEmpty<Trimmed<String>>` takes exactly
the same memory as `String`.

A typealias is an alias, not a new type. If `User.Name` and `Player.Name`
point to the same composition, the compiler treats them as one type and
does not duplicate metadata. In practice, unique compositions are few —
the overhead is negligible.


## Downsides

Migrating an existing project takes time. Replace types in models, remove
redundant checks and tests — best done for a whole module in one go.

At boundaries with external libraries you will need to unwrap and re-wrap.
It is occasionally inconvenient, but it is the price for guarantees inside
your own code.

Validation itself happens at runtime, at creation time — the compiler
cannot know whether a string from the network is empty. What the type
system gives you is that the check runs exactly once, at the boundary,
and can never be skipped afterwards.
