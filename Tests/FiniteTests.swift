// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct FiniteTests {

    @Test internal func wrapper() {
        #expect(Finite<Double>(19.99) != nil)
        #expect(Finite<Double>(0) != nil)
        #expect(Finite<Double>(.nan) == nil)
        #expect(Finite<Double>(.infinity) == nil)
        #expect(Finite<Double>(-.infinity) == nil)
        #expect(Finite<Float>(.nan) == nil)
        #expect(Finite<Decimal>(.nan) == nil)
        #expect(throws: Finite<Double>.Error.self) {
            try Finite<Double>(.infinity)
        }
    }

    @Test internal func measurement() {
        // Division can produce non-finite values — the wrapper catches them
        #expect(Measurement(19.99) != nil)
        #expect(Measurement(expressing: 1 / 0) == nil)
        #expect(Measurement(expressing: 0 / 0) == nil)
    }

    @Test internal func codable() throws {
        let original = try Finite<Double>(19.99)
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == "19.99")
        let decoded = try JSONDecoder().decode(Finite<Double>.self, from: encoded)
        #expect(decoded == original)
    }

    @Test internal func error() {
        let error = Finite<Double>.Error(.nan)
        #expect(error.value.isNaN)
        #expect(error.description == "Value 'nan' must be finite")
    }

}


extension FiniteTests {
    internal typealias Measurement = Finite<Rounded<`0.1`, Double>>
}
