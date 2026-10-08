// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct CapitalizedTests {

    @Test internal func method() {
        func capitalized(_ string: String) -> String {
            return string.capitalized()
        }
        #expect(capitalized("") == "")
        #expect(capitalized("hello world") == "Hello World")
        #expect(capitalized("hello, world!") == "Hello, World!")
        #expect(capitalized("HELLO WORLD") == "Hello World")
        #expect(capitalized("swift best practices") == "Swift Best Practices")

        let once = capitalized("hello world")
        #expect(capitalized(once) == once)
    }

    @Test internal func wrapper() {
        #expect(Capitalized<String>("hello world") == "Hello World")
        #expect(Capitalized<String>("hello, world!") == "Hello, World!")
        #expect(Capitalized<String>("HELLO WORLD") == "Hello World")
        #expect(Capitalized<String>("") == "")
    }

    @Test internal func expressing() {
        #expect(Capitalized<String>(expressing: "hello world") == "Hello World")
        #expect(Capitalized<String>.expressing("hello world") == "Hello World")
        #expect(Capitalized<String>("hello world").asString() == "Hello World")
    }

    @Test internal func literal() {
        let text: Capitalized<String> = "hello world"
        #expect(text.wrapped == "Hello World")
    }

    @Test internal func codable() throws {
        let original = Capitalized<String>("hello world")
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == #""Hello World""#)
        let decoded = try JSONDecoder().decode(Capitalized<String>.self, from: encoded)
        #expect(decoded == original)
        let capitalized = try JSONDecoder().decode(
            Capitalized<String>.self,
            from: try #require(#""hello world""#.data(using: .utf8))
        )
        #expect(capitalized == Capitalized<String>("Hello World"))
    }

}
