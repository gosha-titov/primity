// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct AtLeastTests {

    @Test internal func int() throws {
        #expect(AtLeast<`4`, Int>(3) == nil)
        #expect(AtLeast<`4`, Int>(4) != nil)
        #expect(AtLeast<`4`, Int>(100) != nil)
        #expect((try AtLeast<`4`, Int>(5)).wrapped == 5)
        #expect((try AtLeast<`4`, Int>(expressing: 5)).wrapped == 5)
        let value: AtLeast<`4`, Int>? = 5
        #expect(value?.wrapped == 5)
        let invalid: AtLeast<`4`, Int>? = 3
        #expect(invalid == nil)
        #expect(throws: AtLeast<`4`, Int>.Error.self) {
            try AtLeast<`4`, Int>(3)
        }
    }

    @Test internal func string() throws {
        #expect(Password("hey") == nil)
        #expect(Password("pass") != nil)
        #expect((try Password("password")).wrapped == "password")
        let value: Password? = "secret"
        #expect(value?.wrapped == "secret")
        let invalid: Password? = "hey"
        #expect(invalid == nil)
    }

    @Test internal func collection() throws {
        #expect(AtLeast<`2`, [Int]>([1]) == nil)
        #expect(AtLeast<`2`, [Int]>([1, 2]) != nil)
        #expect((try AtLeast<`2`, [Int]>([1, 2, 3])).wrapped == [1, 2, 3])
        let value: AtLeast<`2`, [Int]>? = [1, 2]
        #expect(value?.wrapped == [1, 2])
        let invalid: AtLeast<`2`, [Int]>? = [1]
        #expect(invalid == nil)
    }

    @Test internal func double() throws {
        #expect(AtLeast<`0.5`, Double>(0.4) == nil)
        #expect(AtLeast<`0.5`, Double>(0.5) != nil)
        #expect((try AtLeast<`0.5`, Double>(0.97)).wrapped == 0.97)
        let value: AtLeast<`0.5`, Double>? = 0.97
        #expect(value?.wrapped == 0.97)
        let invalid: AtLeast<`0.5`, Double>? = 0.4
        #expect(invalid == nil)
    }

    @Test internal func codable() throws {
        let original = try Password("password")
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == "\"password\"")
        let decoded = try JSONDecoder().decode(Password.self, from: encoded)
        #expect(decoded == original)
        let tooShort = try #require("\"hey\"".data(using: .utf8))
        #expect(throws: Password.Error.self) {
            try JSONDecoder().decode(Password.self, from: tooShort)
        }
    }

    @Test internal func error() {
        let error = AtLeast<`4`, String>.Error("hey")
        #expect(error.value == "hey")
        #expect(error.description == "Value 'hey' must be at least 4")
    }

}


extension AtLeastTests {
    private typealias Password = AtLeast<`4`, String>
}
