// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct FoldedTests {

    @Test internal func method() {
        #expect("Émile".folded() == "emile")
        #expect("émile".folded() == "emile")
        #expect("Straße".folded() == "strasse")
        #expect("Café".folded() == "cafe")
        #expect("Crème brûlée".folded() == "creme brulee")
        #expect("hello".folded() == "hello")
    }

    @Test internal func wrapper() {
        #expect(Folded<String>("Émile") == "emile")
        #expect(Folded<String>("Straße") == "strasse")
        #expect(Folded<String>("hello") == "hello")
    }

    @Test internal func composition() {
        let key: SearchKey = "  Émile   Danielle  "
        #expect(key.wrapped == "emile danielle")
        #expect(SearchKey("  CAFÉ ") == SearchKey("cafe"))
    }

    @Test internal func expressing() {
        #expect(Folded<String>(expressing: "Émile") == "emile")
        #expect(Folded<String>.expressing("Émile") == "emile")
        #expect(Folded<String>("Émile").expressed() == "emile")
        #expect(Folded<String>("Émile").asString() == "emile")
    }

    @Test internal func literal() {
        let key: Folded<String> = "Café"
        #expect(key.wrapped == "cafe")
    }

    @Test internal func dictionaryKey() {
        let contacts: Contacts = ["Émile": 1, "  CAFÉ ": 2]
        #expect(contacts[SearchKey(expressing: "emile")] == 1)
        #expect(contacts[SearchKey(expressing: "cafe")] == 2)
        #expect(contacts[SearchKey(expressing: "unknown")] == nil)
    }

    @Test internal func codable() throws {
        let original = Folded<String>("Émile")
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == "\"emile\"")
        let decoded = try JSONDecoder().decode(Folded<String>.self, from: encoded)
        #expect(decoded == original)
        let folded = try JSONDecoder().decode(
            Folded<String>.self,
            from: try #require("\"CAFÉ\"".data(using: .utf8))
        )
        #expect(folded == Folded<String>("cafe"))
    }

    @Test internal func equality() {
        #expect(Folded<String>("Émile") == Folded<String>("emile"))
        #expect(Folded<String>("Café") != Folded<String>("tea"))
    }

}


extension FoldedTests {
    private typealias SearchKey = Folded<Collapsed<Trimmed<String>>>
    private typealias Contacts = [SearchKey: Int]
}
