// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct TrimmedTests {

    @Test internal func method() {
        func trimmed(_ string: String) -> String {
            return string.trimmed()
        }
        #expect(trimmed("") == "")
        #expect(trimmed("hello world") == "hello world")
        #expect(trimmed(" hello ") == "hello")
        #expect(trimmed("\t hello world \n") == "hello world")
        #expect(trimmed("   \n\t  ") == "")
        #expect(trimmed("  a  b  ") == "a  b")
        #expect(trimmed("\r\nhello\r\n") == "hello")

        let once = trimmed("  hello  ")
        #expect(trimmed(once) == once)
    }

    @Test internal func wrapper() {
        #expect(Trimmed<String>(" hello ") == "hello")
        #expect(Trimmed<String>("\t hello world \n") == "hello world")
        #expect(Trimmed<String>("  a  b  ") == "a  b")
        #expect(Trimmed<String>("   \n\t  ") == "")
    }

    @Test internal func expressing() {
        #expect(Trimmed<String>(expressing: " hello ") == "hello")
        #expect(Trimmed<String>.expressing(" hello ") == "hello")
        #expect(Trimmed<String>(" hello ").asString() == "hello")
    }

    @Test internal func literal() {
        let text: Trimmed<String> = " hello "
        #expect(text.wrapped == "hello")
    }

    @Test internal func codable() throws {
        let original = Trimmed<String>(" hello ")
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == #""hello""#)
        let decoded = try JSONDecoder().decode(Trimmed<String>.self, from: encoded)
        #expect(decoded == original)
        let trimmed = try JSONDecoder().decode(
            Trimmed<String>.self,
            from: try #require(#"" hello ""#.data(using: .utf8))
        )
        #expect(trimmed == Trimmed<String>("hello"))
    }

}
