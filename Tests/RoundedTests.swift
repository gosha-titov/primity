// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct RoundedTests {

    @Test internal func methodNearest() {
        #expect(19.999.rounded(toStep: 0.01) == 20.0)
        #expect(0.126.rounded(toStep: 0.01) == 0.13)
        #expect((-0.126).rounded(toStep: 0.01) == -0.13)
        #expect(4.25.rounded(toStep: 0.5) == 4.5)
        #expect((-4.25).rounded(toStep: 0.5) == -4.5)
        #expect(9.rounded(toStep: 8) == 8)
        #expect(12.rounded(toStep: 8) == 16)
        #expect((-12).rounded(toStep: 8) == -16)
        #expect(Decimal(19.999).rounded(toStep: 0.01) == 20)
        #expect(Decimal(2.5).rounded(toStep: 1) == 3)
        #expect(Decimal(-2.5).rounded(toStep: 1) == -3)
    }

    @Test internal func methodUp() {
        // Away from zero — the magnitude grows
        #expect(0.123.rounded(toStep: 0.01, rule: .up) == 0.13)
        #expect((-0.123).rounded(toStep: 0.01, rule: .up) == -0.13)
        #expect(10.25.rounded(toStep: 0.5, rule: .up) == 10.5)
        #expect((-10.25).rounded(toStep: 0.5, rule: .up) == -10.5)
        #expect(9.rounded(toStep: 8, rule: .up) == 16)
        #expect((-9).rounded(toStep: 8, rule: .up) == -16)
        #expect(Decimal(10.25).rounded(toStep: 0.5, rule: .up) == Decimal(10.5))
        #expect(Decimal(-10.25).rounded(toStep: 0.5, rule: .up) == Decimal(-10.5))
        #expect(Decimal(9).rounded(toStep: 8, rule: .up) == 16)
    }

    @Test internal func methodDown() {
        // Toward zero — the magnitude shrinks
        #expect(0.126.rounded(toStep: 0.01, rule: .down) == 0.12)
        #expect((-0.126).rounded(toStep: 0.01, rule: .down) == -0.12)
        #expect(10.25.rounded(toStep: 0.5, rule: .down) == 10.0)
        #expect((-10.25).rounded(toStep: 0.5, rule: .down) == -10.0)
        #expect(19.99.rounded(toStep: 0.01, rule: .down) == 19.98)
        #expect(9.rounded(toStep: 8, rule: .down) == 8)
        #expect((-9).rounded(toStep: 8, rule: .down) == -8)
        #expect(Decimal(10.25).rounded(toStep: 0.5, rule: .down) == 10)
        #expect(Decimal(-10.25).rounded(toStep: 0.5, rule: .down) == -10)
        #expect(Decimal(9).rounded(toStep: 8, rule: .down) == 8)
    }

    @Test internal func wrapper() {
        #expect(Rounded<`0.01`, Double>(19.999) == 20.0)
        // Inexact step: 1999 * 0.01 lands on a neighbor of the 19.99 literal
        #expect(Rounded<`0.01`, Double>(19.99) == 19.990000000000002)
        #expect(Rounded<`1.0`, Double>(-2.5) == -3.0)
        #expect(Rounded<`8`, Int>(13) == 16)
        // The general form with an explicit rule
        #expect(RoundedWith<`0.5`, RoundingRule.Nearest, Double>(4.26) == 4.5)
        #expect(RoundedUp<`0.01`, Double>(0.123) == 0.13)
        #expect(RoundedUp<`0.01`, Double>(-0.123) == -0.13)
        #expect(RoundedUp<`0.5`, Double>(-10.25) == -10.5)
        #expect(RoundedDown<`0.01`, Double>(0.126) == 0.12)
        #expect(RoundedDown<`0.01`, Double>(-0.126) == -0.12)
        #expect(RoundedDown<`0.5`, Double>(-10.25) == -10.0)
    }

    @Test internal func price() throws {
        #expect(Price(19.99) != nil)
        #expect((try Price(19.999)).wrapped == 20.0)
        #expect(Price(0.001) == nil)
        #expect(Price(-0.001) == nil)
        #expect(Price(-9.99) == nil)
    }

    @Test internal func rate() throws {
        #expect(Rate(4.567) != nil)
        #expect((try Rate(4.567)).wrapped == 4.57)
        #expect(Rate(-0.001) != nil)
        #expect(Rate(-0.01) == nil)
    }

    @Test internal func fee() throws {
        #expect(Fee(10.251) != nil)
        #expect((try Fee(10.251)).wrapped == 10.26)
        #expect(Fee(-1.0) == nil)
    }

    @Test internal func displayedRating() throws {
        #expect(DisplayedRating(4.99) != nil)
        #expect((try DisplayedRating(4.99)).wrapped == 4.9)
        // Toward zero: -0.01 rounds to -0.0, which is still within the range
        #expect(DisplayedRating(-0.01)?.wrapped == 0.0)
        #expect(DisplayedRating(5.5) == nil)
    }

    @Test internal func expressing() {
        #expect(Rounded<`0.01`, Double>(expressing: 0.126) == 0.13)
        #expect(Rounded<`0.01`, Double>.expressing(0.126) == 0.13)
        #expect(Rounded<`0.01`, Double>(0.126).expressed() == 0.13)
        #expect(Rounded<`0.01`, Double>(0.126).asDouble() == 0.13)
    }

    @Test internal func literal() {
        let price: Rounded<`0.01`, Double> = 19.999
        #expect(price.wrapped == 20.0)
        let fee: RoundedUp<`0.01`, Double> = 10.251
        #expect(fee.wrapped == 10.26)
    }

    @Test internal func codable() throws {
        let original = Rounded<`0.5`, Double>(4.26)
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == "4.5")
        let decoded = try JSONDecoder().decode(Rounded<`0.5`, Double>.self, from: encoded)
        #expect(decoded == original)
        let rounded = try JSONDecoder().decode(
            Rounded<`0.5`, Double>.self,
            from: try #require("4.26".data(using: .utf8))
        )
        #expect(rounded == Rounded<`0.5`, Double>(4.5))
    }

}


extension RoundedTests {
    internal typealias Price = Positive<Rounded<`0.01`, Double>>
    internal typealias Rate = NonNegative<Rounded<`0.01`, Double>>
    internal typealias Fee = NonNegative<RoundedUp<`0.01`, Double>>
    internal typealias DisplayedRating = Within<`0.0`, `5.0`, RoundedDown<`0.1`, Double>>
    internal enum `5.0`: Constant {
        internal static let value = 5.0
    }
    internal enum `8`: Constant {
        internal static let value = 8
    }
}
