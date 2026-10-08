// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct WithinTests {

    @Test internal func int() throws {
        #expect(Within<`1`, `5`, Int>(0) == nil)
        #expect(Within<`1`, `5`, Int>(7) == nil)
        #expect(Within<`1`, `5`, Int>(1) != nil)
        #expect(Within<`1`, `5`, Int>(5) != nil)
        #expect((try Within<`1`, `5`, Int>(3)).wrapped == 3)
        #expect((try Within<`1`, `5`, Int>(expressing: 3)).wrapped == 3)
        let value: Within<`1`, `5`, Int>? = 3
        #expect(value?.wrapped == 3)
        let invalid: Within<`1`, `5`, Int>? = 9
        #expect(invalid == nil)
        #expect(throws: Within<`1`, `5`, Int>.Error.self) {
            try Within<`1`, `5`, Int>(7)
        }
        #expect(throws: Within<`1`, `5`, Int>.Error.self) {
            try Within<`1`, `5`, Int>(expressing: 0)
        }
    }

    @Test internal func double() throws {
        #expect(Within<`0.0`, `1.0`, Double>(-0.5) == nil)
        #expect(Within<`0.0`, `1.0`, Double>(1.5) == nil)
        #expect(Within<`0.0`, `1.0`, Double>(0.0) != nil)
        #expect(Within<`0.0`, `1.0`, Double>(1.0) != nil)
        #expect((try Within<`0.0`, `1.0`, Double>(0.97)).wrapped == 0.97)
        let value: Within<`0.0`, `1.0`, Double>? = 0.97
        #expect(value?.wrapped == 0.97)
        let invalid: Within<`0.0`, `1.0`, Double>? = 1.5
        #expect(invalid == nil)
        #expect(throws: Within<`0.0`, `1.0`, Double>.Error.self) {
            try Within<`0.0`, `1.0`, Double>(1.5)
        }
    }

    @Test internal func collection() throws {
        #expect(Within<`1`, `3`, [Int]>([]) == nil)
        #expect(Within<`1`, `3`, [Int]>([1, 2, 3, 4]) == nil)
        #expect(Within<`1`, `3`, [Int]>([1]) != nil)
        #expect(Within<`1`, `3`, [Int]>([1, 2, 3]) != nil)
        #expect((try Within<`1`, `3`, [Int]>([1, 2])).wrapped == [1, 2])

        #expect(Within<`1`, `5`, String>("") == nil)
        #expect(Within<`1`, `5`, String>("hello!") == nil)
        #expect(Within<`1`, `5`, String>("hello") != nil)
        #expect((try Within<`1`, `5`, String>("hey")).wrapped == "hey")
    }

    @Test internal func codable() throws {
        let original = try Within<`1`, `5`, Int>(3)
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == "3")
        let decoded = try JSONDecoder().decode(Within<`1`, `5`, Int>.self, from: encoded)
        #expect(decoded == original)
        let outOfBounds = try #require("7".data(using: .utf8))
        #expect(throws: Within<`1`, `5`, Int>.Error.self) {
            try JSONDecoder().decode(Within<`1`, `5`, Int>.self, from: outOfBounds)
        }
    }

    @Test internal func equality() throws {
        #expect(try Within<`1`, `5`, Int>(3) == 3)
        #expect(try Within<`1`, `5`, Int>(3) != 4)
        #expect(try Within<`1`, `5`, Int>(3) == Within<`1`, `5`, Int>(3))
        #expect(try Within<`1`, `5`, Int>(3) != Within<`1`, `5`, Int>(4))
    }

}
