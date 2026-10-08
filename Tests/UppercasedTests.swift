// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct UppercasedTests {

    @Test internal func method() {
        func uppercased(_ string: String) -> String {
            return string.uppercased()
        }
        #expect(uppercased("") == "")
        #expect(uppercased("hello world") == "HELLO WORLD")
        #expect(uppercased("Hello, World!") == "HELLO, WORLD!")
        #expect(uppercased("café") == "CAFÉ")
        #expect(uppercased("123 abc !") == "123 ABC !")

        let once = uppercased("hello world")
        #expect(uppercased(once) == once)
    }

    @Test internal func wrapper() {
        #expect(Uppercased<String>("hello world") == "HELLO WORLD")
        #expect(Uppercased<String>("Hello, World!") == "HELLO, WORLD!")
        #expect(Uppercased<String>("url") == "URL")
        #expect(Uppercased<String>("") == "")
    }

    @Test internal func expressing() {
        #expect(Uppercased<String>(expressing: "hello world") == "HELLO WORLD")
        #expect(Uppercased<String>.expressing("hello world") == "HELLO WORLD")
        #expect(Uppercased<String>("hello world").asString() == "HELLO WORLD")
    }

    @Test internal func literal() {
        let text: Uppercased<String> = "hello world"
        #expect(text.wrapped == "HELLO WORLD")
    }

    @Test internal func codable() throws {
        let original = Uppercased<String>("hello world")
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == #""HELLO WORLD""#)
        let decoded = try JSONDecoder().decode(Uppercased<String>.self, from: encoded)
        #expect(decoded == original)
        let uppercased = try JSONDecoder().decode(
            Uppercased<String>.self,
            from: try #require(#""hello world""#.data(using: .utf8))
        )
        #expect(uppercased == Uppercased<String>("HELLO WORLD"))
    }

}
