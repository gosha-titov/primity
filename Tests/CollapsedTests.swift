// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct CollapsedTests {

    @Test internal func method() {
        func collapsed(_ string: String) -> String {
            return string.collapsed()
        }
        #expect(collapsed("") == "")
        #expect(collapsed("hello world") == "hello world")
        #expect(collapsed("ABC \n   DEF  \t GHI  JKL") == "ABC DEF GHI JKL")
        #expect(collapsed("   \n\t  ") == " ")
    }

    @Test internal func wrapper() {
        #expect(Collapsed<String>("Hello, \n  world!") == "Hello, world!")
        #expect(Collapsed<String>("ABC \n   DEF  \t GHI  JKL") == "ABC DEF GHI JKL")
        #expect(Collapsed<String>("   \n\t  ") == " ")
    }

    @Test internal func expressing() {
        #expect(Collapsed<String>(expressing: "a  \n b") == "a b")
        #expect(Collapsed<String>.expressing("a  \n b") == "a b")
        #expect(Collapsed<String>("a  \n b").asString() == "a b")
    }

    @Test internal func literal() {
        let text: Collapsed<String> = "Hi, \n  there"
        #expect(text.wrapped == "Hi, there")
    }

    @Test internal func codable() throws {
        let original = Collapsed<String>("Hello, \n  world!")
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == #""Hello, world!""#)
        let decoded = try JSONDecoder().decode(Collapsed<String>.self, from: encoded)
        #expect(decoded == original)
        let collapsed = try JSONDecoder().decode(
            Collapsed<String>.self,
            from: try #require(#""Hello, \n  world!""#.data(using: .utf8))
        )
        #expect(collapsed == Collapsed<String>("Hello, world!"))
    }

}
