// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct TruncatedTests {

    @Test internal func method() {
        func truncated(_ string: String, to length: Int) -> String {
            return string.truncated(to: length)
        }
        #expect(truncated("", to: 5) == "")
        #expect(truncated("hello", to: 5) == "hello")
        #expect(truncated("hello world", to: 5) == "hello")
        #expect(truncated("hello", to: 100) == "hello")
        #expect(truncated("hello", to: 0) == "")
        #expect(truncated("👋🌍abc", to: 2) == "👋🌍")

        let once = truncated("hello world", to: 5)
        #expect(truncated(once, to: 5) == once)
    }

    @Test internal func wrapper() {
        #expect(Truncated<`5`, String>("Hello, world!") == "Hello")
        #expect(Truncated<`5`, String>("Hi") == "Hi")
        #expect(Truncated<`0`, String>("Hi") == "")
        #expect(Truncated<`100`, String>("Hello, world!") == "Hello, world!")
    }

    @Test internal func expressing() {
        #expect(Truncated<`5`, String>(expressing: "Hello, world!") == "Hello")
        #expect(Truncated<`5`, String>.expressing("Hello, world!") == "Hello")
        #expect(Truncated<`5`, String>("Hello, world!").asString() == "Hello")
    }

    @Test internal func literal() {
        let text: Truncated<`5`, String> = "Hello, world!"
        #expect(text.wrapped == "Hello")
    }

    @Test internal func codable() throws {
        let original = Truncated<`5`, String>("Hello, world!")
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == #""Hello""#)
        let decoded = try JSONDecoder().decode(Truncated<`5`, String>.self, from: encoded)
        #expect(decoded == original)
        let truncated = try JSONDecoder().decode(
            Truncated<`5`, String>.self,
            from: try #require(#""Hello, world!""#.data(using: .utf8))
        )
        #expect(truncated == Truncated<`5`, String>("Hello"))
    }

}
