// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct PositiveTests {

    @Test internal func int() throws {
        #expect(Positive<Int>(0) == nil)
        #expect(Positive<Int>(-3) == nil)
        #expect(Positive<Int>(5) != nil)
        #expect((try Positive(5)).wrapped == 5)
        #expect((try Positive<Int>(expressing: 5)).wrapped == 5)
        let value: Positive<Int>? = 42
        #expect(value?.wrapped == 42)
        let invalid: Positive<Int>? = -1
        #expect(invalid == nil)
        #expect(throws: Positive<Int>.Error.self) {
            try Positive<Int>(0)
        }
        #expect(throws: Positive<Int>.Error.self) {
            try Positive<Int>(expressing: -3)
        }
    }

    @Test internal func double() throws {
        #expect(Positive<Double>(0.0) == nil)
        #expect(Positive<Double>(-0.5) == nil)
        #expect(Positive<Double>(263.333) != nil)
        #expect((try Positive(263.333)).wrapped == 263.333)
        #expect((try Positive<Double>(expressing: 48.27)).wrapped == 48.27)
        let value: Positive<Double>? = 263.333
        #expect(value?.wrapped == 263.333)
        let invalid: Positive<Double>? = -0.5
        #expect(invalid == nil)
        #expect(throws: Positive<Double>.Error.self) {
            try Positive<Double>(-0.5)
        }
    }

    @Test internal func codable() throws {
        let original = try Positive(5)
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == "5")
        let decoded = try JSONDecoder().decode(Positive<Int>.self, from: encoded)
        #expect(decoded == original)
        let negative = try #require("-3".data(using: .utf8))
        #expect(throws: Positive<Int>.Error.self) {
            try JSONDecoder().decode(Positive<Int>.self, from: negative)
        }
    }

    @Test internal func comparison() throws {
        #expect(try Positive(5) == 5)
        #expect(try Positive(5) != 6)
        let lower = try Positive(1)
        let higher = try Positive(2)
        #expect(lower < higher)
        #expect(higher > lower)
    }

}
