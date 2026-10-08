// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct RaggedTests {

    @Test internal func method() {
        func ragged(_ string: String) -> String {
            return string.ragged()
        }
        #expect(ragged("") == "")
        #expect(ragged("hello world") == "hello world")
        #expect(ragged("hello    ") == "hello")
        #expect(ragged("\t hello world \t ") == "\t hello world")
        #expect(ragged("   \t  ") == "")
        #expect(ragged("""
        hello
        world   \t
        """) ==  """
        hello
        world
        """)

        #expect(ragged("a  \nb\t\n") == "a\nb\n")
        #expect(ragged("a  \r\nb\t\r\nc") == "a\r\nb\r\nc")
        #expect(ragged("a  \rb  \r") == "a\rb\r")
        #expect(ragged("a  \u{2028}b \u{2029} ") == "a\u{2028}b\u{2029}")
        #expect(ragged("a  \nb  \r\nc  \rd  ") == "a\nb\r\nc\rd")

        #expect(ragged("  a  b  ") == "  a  b")
        #expect(ragged("a\n   \nb") == "a\n\nb")
        #expect(ragged("a\r\n \t \r\nb") == "a\r\n\r\nb")
        #expect(ragged("a\u{A0}\u{A0}") == "a")

        let once = ragged("  a  \r\n b  \n  ")
        #expect(ragged(once) == once)
    }

    @Test internal func wrapper() {
        #expect(Ragged<String>("hello    ") == "hello")
        #expect(Ragged<String>("\t hello world \t ") == "\t hello world")
        #expect(Ragged<String>("a  \nb\t\n") == "a\nb\n")
        #expect(Ragged<String>("a\u{A0}\u{A0}") == "a")
    }

    @Test internal func expressing() {
        #expect(Ragged<String>(expressing: "hello   ") == "hello")
        #expect(Ragged<String>.expressing("hello   ") == "hello")
        #expect(Ragged<String>("hello   ").asString() == "hello")
    }

    @Test internal func literal() {
        let text: Ragged<String> = "hello   "
        #expect(text.wrapped == "hello")
    }

    @Test internal func codable() throws {
        let original = Ragged<String>("hello   ")
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == #""hello""#)
        let decoded = try JSONDecoder().decode(Ragged<String>.self, from: encoded)
        #expect(decoded == original)
        let ragged = try JSONDecoder().decode(
            Ragged<String>.self,
            from: try #require(#""hello   ""#.data(using: .utf8))
        )
        #expect(ragged == Ragged<String>("hello"))
    }

}
