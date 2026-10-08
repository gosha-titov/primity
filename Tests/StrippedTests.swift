// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct StrippedTests {

    @Test internal func method() {
        func stripped(_ string: String) -> String {
            return string.stripped()
        }
        #expect(stripped("") == "")
        #expect(stripped("0 1 2 3 4 5 6 7 8 9 ! @ # $ % ^ & * ( ) , . ? /") == "0 1 2 3 4 5 6 7 8 9 ! @ # $ % ^ & * ( ) , . ? /")
        #expect(stripped("hello world") == "hello world")
        #expect(stripped("👋🌍3️⃣") == "")
        #expect(stripped("Hello, 👋 World! 🌍 Let's meet at 3️⃣ PM.") == "Hello,  World!  Let's meet at  PM.")
        #expect(stripped("❤️") == "")
        #expect(stripped("©") == "©")
        #expect(stripped("©️") == "")
    }

    @Test internal func wrapper() {
        #expect(Stripped<String>("Hello 👋") == "Hello ")
        #expect(Stripped<String>("👋🌍3️⃣") == "")
        #expect(Stripped<String>("Hello, 👋 World! 🌍 Let's meet at 3️⃣ PM.") == "Hello,  World!  Let's meet at  PM.")
    }

    @Test internal func expressing() {
        #expect(Stripped<String>(expressing: "a 👋") == "a ")
        #expect(Stripped<String>.expressing("a 👋") == "a ")
        #expect(Stripped<String>("a 👋").asString() == "a ")
    }

    @Test internal func literal() {
        let text: Stripped<String> = "Hi 👋"
        #expect(text.wrapped == "Hi ")
    }

    @Test internal func codable() throws {
        let original = Stripped<String>("Hello 👋")
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == #""Hello ""#)
        let decoded = try JSONDecoder().decode(Stripped<String>.self, from: encoded)
        #expect(decoded == original)
        let stripped = try JSONDecoder().decode(
            Stripped<String>.self,
            from: try #require(#""Hello 👋""#.data(using: .utf8))
        )
        #expect(stripped == Stripped<String>("Hello "))
    }

}
