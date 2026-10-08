// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that strips its value on creation.
///
/// Decorative elements (like emojis) are removed during initialization.
///
/// ## Example
/// ```
/// let text = Stripped("Hello, 👋 World! 🌍 Let's meet at 3️⃣ PM.")
/// print(text.value) // "Hello,  World!  Let's meet at  PM."
/// ```
public struct Stripped<Wrapped>: Wrapping where Wrapped: Strippable {

    /// The underlying stripped textual value.
    public let wrapped: Wrapped

    /// Creates an instance by stripping the given value.
    public init(_ value: Wrapped) {
        self.wrapped = value.stripped()
    }

}


extension Stripped: Expressible, AnyExpressible where Wrapped: Expressible {}

extension Stripped: Codable where Wrapped: Codable {}
extension Stripped: Equatable where Wrapped: Equatable {}
extension Stripped: Hashable where Wrapped: Hashable {}
extension Stripped: Sendable where Wrapped: Sendable {}

extension Stripped: Sequence where Wrapped: Sequence {}
extension Stripped: Collection where Wrapped: Collection {}
extension Stripped: BidirectionalCollection where Wrapped: BidirectionalCollection {}

extension Stripped: ArrayExpressible, ExpressibleByArrayLiteral where Wrapped: ArrayExpressible {}
extension Stripped: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Wrapped: ExpressibleByStringLiteral {}
