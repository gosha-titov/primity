// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct LowercasedTests {

    @Test internal func method() {
        func lowercased(_ string: String) -> String {
            return string.lowercased()
        }
        #expect(lowercased("") == "")
        #expect(lowercased("hello world") == "hello world")
        #expect(lowercased("HELLO WORLD") == "hello world")
        #expect(lowercased("Hello, World!") == "hello, world!")
        #expect(lowercased("CAFÉ") == "café")
        #expect(lowercased("123 ABC !") == "123 abc !")

        let once = lowercased("HELLO WORLD")
        #expect(lowercased(once) == once)
    }

    @Test internal func wrapper() {
        #expect(Lowercased<String>("HELLO WORLD") == "hello world")
        #expect(Lowercased<String>("Hello, World!") == "hello, world!")
        #expect(Lowercased<String>("Memory") == "memory")
        #expect(Lowercased<String>("") == "")
    }

    @Test internal func expressing() {
        #expect(Lowercased<String>(expressing: "HELLO WORLD") == "hello world")
        #expect(Lowercased<String>.expressing("HELLO WORLD") == "hello world")
        #expect(Lowercased<String>("HELLO WORLD").asString() == "hello world")
    }

    @Test internal func literal() {
        let text: Lowercased<String> = "HELLO WORLD"
        #expect(text.wrapped == "hello world")
    }

    @Test internal func codable() throws {
        let original = Lowercased<String>("HELLO WORLD")
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == #""hello world""#)
        let decoded = try JSONDecoder().decode(Lowercased<String>.self, from: encoded)
        #expect(decoded == original)
        let lowercased = try JSONDecoder().decode(
            Lowercased<String>.self,
            from: try #require(#""HELLO WORLD""#.data(using: .utf8))
        )
        #expect(lowercased == Lowercased<String>("hello world"))
    }

}
