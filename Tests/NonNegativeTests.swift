// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct NonNegativeTests {

    @Test internal func int() throws {
        #expect(NonNegative<Int>(-3) == nil)
        #expect(NonNegative<Int>(0) != nil)
        #expect(NonNegative<Int>(5) != nil)
        #expect((try NonNegative(0)).wrapped == 0)
        #expect((try NonNegative<Int>(expressing: 5)).wrapped == 5)
        let value: NonNegative<Int>? = 42
        #expect(value?.wrapped == 42)
        let invalid: NonNegative<Int>? = -1
        #expect(invalid == nil)
        #expect(throws: NonNegative<Int>.Error.self) {
            try NonNegative<Int>(-3)
        }
        #expect(throws: NonNegative<Int>.Error.self) {
            try NonNegative<Int>(expressing: -3)
        }
    }

    @Test internal func double() throws {
        #expect(NonNegative<Double>(-0.5) == nil)
        #expect(NonNegative<Double>(0.0) != nil)
        #expect(NonNegative<Double>(48.27) != nil)
        #expect((try NonNegative(48.27)).wrapped == 48.27)
        #expect((try NonNegative<Double>(expressing: 48.27)).wrapped == 48.27)
        let level: NonNegative<Double>? = 48.27
        #expect(level?.wrapped == 48.27)
        let invalid: NonNegative<Double>? = -0.5
        #expect(invalid == nil)
        #expect(throws: NonNegative<Double>.Error.self) {
            try NonNegative<Double>(-0.5)
        }
    }

    @Test internal func codable() throws {
        let original = try NonNegative(5)
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == "5")
        let decoded = try JSONDecoder().decode(NonNegative<Int>.self, from: encoded)
        #expect(decoded == original)
        let negative = try #require("-3".data(using: .utf8))
        #expect(throws: NonNegative<Int>.Error.self) {
            try JSONDecoder().decode(NonNegative<Int>.self, from: negative)
        }
    }

    @Test internal func comparison() throws {
        #expect(try NonNegative(5) == 5)
        #expect(try NonNegative(5) != 6)
        let lower = try NonNegative(1)
        let higher = try NonNegative(2)
        #expect(lower < higher)
        #expect(higher > lower)
    }

}
