// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct FirstLastTests {

    @Test internal func methods() {
        #expect("hello world".first(5) == "hello")
        #expect("hello world".last(5) == "world")
        #expect("hello".first(100) == "hello")
        #expect("hello".last(100) == "hello")
        #expect("hello".first(0).isEmpty)
        #expect("hello".last(0).isEmpty)
        #expect("👋🌍abc".first(2) == "👋🌍")
        #expect("👋🌍abc".last(2) == "bc")
    }

    @Test internal func strings() {
        #expect(First<`5`, String>("Hello, world!") == "Hello")
        #expect(Last<`5`, String>("Hello, world!") == "orld!")
        #expect(First<`5`, String>("Hi") == "Hi")
        #expect(Last<`5`, String>("Hi") == "Hi")
        #expect(First<`0`, String>("Hi").wrapped.isEmpty)
        #expect(Last<`0`, String>("Hi").wrapped.isEmpty)
        #expect(First<`100`, String>("Hello, world!") == "Hello, world!")
        #expect(Last<`100`, String>("Hello, world!") == "Hello, world!")
    }

    @Test internal func collections() {
        #expect(First<`3`, [Int]>([1, 2, 3, 4, 5]) == [1, 2, 3])
        #expect(Last<`3`, [Int]>([1, 2, 3, 4, 5]) == [3, 4, 5])
        #expect(First<`3`, [Int]>([1, 2]) == [1, 2])
        #expect(Last<`3`, [Int]>([1, 2]) == [1, 2])
        #expect(First<`0`, [Int]>([1, 2]).wrapped.isEmpty)
        #expect(Last<`0`, [Int]>([1, 2]).wrapped.isEmpty)
    }

    @Test internal func expressing() {
        #expect(First<`5`, String>(expressing: "Hello, world!") == "Hello")
        #expect(Last<`5`, String>.expressing("Hello, world!") == "orld!")
        #expect(First<`5`, String>("Hello, world!").asString() == "Hello")
        #expect(Last<`4`, String>("4111111111111111").asString() == "1111")
    }

    @Test internal func literal() {
        let text: First<`5`, String> = "Hello, world!"
        #expect(text.wrapped == "Hello")
        let items: Last<`3`, [Int]> = [1, 2, 3, 4, 5]
        #expect(items.wrapped == [3, 4, 5])
    }

    @Test internal func codable() throws {
        let original = Last<`5`, String>("Hello, world!")
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == #""orld!""#)
        let decoded = try JSONDecoder().decode(Last<`5`, String>.self, from: encoded)
        #expect(decoded == original)
        let cut = try JSONDecoder().decode(
            First<`5`, String>.self,
            from: try #require(#""Hello, world!""#.data(using: .utf8))
        )
        #expect(cut == First<`5`, String>("Hello"))
    }

    @Test internal func nesting() {
        typealias Tag = NonEmpty<Lowercased<First<`100`, Collapsed<Trimmed<Stripped<String>>>>>>
        let tag: Tag! = "  Swift   💙 DEvelopment   💻  "
        #expect(tag == "swift development")
        #expect(First<`3`, Collapsed<String>>("a     b") == "a b")
        #expect(Collapsed<Last<`3`, String>>("a     b") == " b")
        #expect(Last<`3`, Collapsed<String>>("a     b") == "a b")
        #expect(Collapsed<First<`3`, String>>("a     b") == "a ")
    }

}
