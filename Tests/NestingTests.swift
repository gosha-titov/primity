// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct NestingTests {

    @Test internal func tag() {
        typealias Tag = NonEmpty<Lowercased<Truncated<`100`, Collapsed<Trimmed<Stripped<String>>>>>>
        var tag: Tag! = "  Swift   💙 DEvelopment   💻  "
        #expect(tag == "swift development")
        tag = " 💙 \n 💻"
        #expect(tag == nil)
    }

    @Test internal func name() {
        typealias Name = NonEmpty<Trimmed<String>>
        var name: Name! = "  Mia  "
        #expect(name == "Mia")
        name = "   "
        #expect(name == nil)
    }

    @Test internal func username() {
        typealias Username = NonEmpty<Lowercased<Trimmed<String>>>
        var username: Username! = "  Alice  "
        #expect(username == "alice")
        username = "   "
        #expect(username == nil)
    }

    @Test internal func order() {
        typealias CollapseThenTruncate = Truncated<`3`, Collapsed<String>>
        typealias TruncateThenCollapse = Collapsed<Truncated<`3`, String>>
        #expect(CollapseThenTruncate("a     b") == "a b")
        #expect(TruncateThenCollapse("a     b") == "a ")
    }

    @Test internal func numbers() {
        typealias Numbers = NonEmpty<Ascended<[Int]>>
        var numbers: Numbers! = [3, 1, 2]
        #expect(numbers == [1, 2, 3])
        numbers = []
        #expect(numbers == nil)
    }

    @Test internal func accessors() {
        typealias Numbers = NonEmpty<Ascended<[Int]>>
        let numbers: Numbers! = [3, 1, 2]
        #expect(numbers.count == 3)
        #expect(numbers.first == 1)
        #expect(numbers.last == 3)
        #expect(numbers.min() == 1)
        #expect(numbers.max() == 3)
    }

    @Test internal func expressed() {
        typealias Text = Stripped<Collapsed<Trimmed<String>>>
        let text = Text(expressing: "  a 👋   b  ")
        #expect(text.asString() == "a b")
        #expect(text.expressed() == "a b")
        #expect(text.wrapped.wrapped.wrapped == "a b")
    }

    @Test internal func codable() throws {
        typealias Tag = NonEmpty<Lowercased<Trimmed<String>>>
        let original = try Tag("  Hello  ")
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == #""hello""#)
        let decoded = try JSONDecoder().decode(Tag.self, from: encoded)
        #expect(decoded == original)
        let empty = try #require(#""   ""#.data(using: .utf8))
        #expect(throws: Tag.Error.self) {
            try JSONDecoder().decode(Tag.self, from: empty)
        }
    }

}
