// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct CycledTests {

    @Test internal func methodOnIntegers() {
        #expect(0.cycled(through: 0..<8) == 0)
        #expect(7.cycled(through: 0..<8) == 7)
        #expect(8.cycled(through: 0..<8) == 0)
        #expect(9.cycled(through: 0..<8) == 1)
        #expect(15.cycled(through: 0..<8) == 7)
        #expect(16.cycled(through: 0..<8) == 0)
        #expect((-1).cycled(through: 0..<8) == 7)
        #expect((-7).cycled(through: 0..<8) == 1)
        #expect((-8).cycled(through: 0..<8) == 0)
        #expect((-9).cycled(through: 0..<8) == 7)
    }

    @Test internal func methodOnDoubles() {
        #expect(0.0.cycled(through: 0.0..<360.0) == 0.0)
        #expect(350.0.cycled(through: 0.0..<360.0) == 350.0)
        #expect(360.0.cycled(through: 0.0..<360.0) == 0.0)
        #expect(370.0.cycled(through: 0.0..<360.0) == 10.0)
        #expect(720.0.cycled(through: 0.0..<360.0) == 0.0)
        #expect((-10.0).cycled(through: 0.0..<360.0) == 350.0)
        #expect((-360.0).cycled(through: 0.0..<360.0) == 0.0)
        #expect(190.0.cycled(through: -180.0..<180.0) == -170.0)
    }

    @Test internal func wrapper() {
        #expect(Cycled<`0`, `8`, Int>(7) == 7)
        #expect(Cycled<`0`, `8`, Int>(8) == 0)
        #expect(Cycled<`0`, `8`, Int>(9) == 1)
        #expect(Cycled<`0`, `8`, Int>(-1) == 7)
        #expect(Cycled<`0.0`, `360.0`, Double>(370.0) == 10.0)
        #expect(Cycled<`0.0`, `360.0`, Double>(-10.0) == 350.0)
        #expect(Cycled<`-180.0`, `180.0`, Double>(190.0) == -170.0)
    }

    @Test internal func carouselIndex() {
        #expect(CarouselIndex<`8`>(0) == 0)
        #expect(CarouselIndex<`8`>(9) == 1)
        #expect(CarouselIndex<`8`>(-1) == 7)
    }

    @Test internal func expressing() {
        #expect(Cycled<`0`, `8`, Int>(expressing: 9) == 1)
        #expect(Cycled<`0`, `8`, Int>.expressing(9) == 1)
        #expect(Cycled<`0`, `8`, Int>(9).expressed() == 1)
        #expect(Cycled<`0`, `8`, Int>(9).asInt() == 1)
    }

    @Test internal func literal() {
        let index: Cycled<`0`, `8`, Int> = 9
        #expect(index.wrapped == 1)
        let hue: Cycled<`0.0`, `360.0`, Double> = 370.0
        #expect(hue.wrapped == 10.0)
    }

    @Test internal func codable() throws {
        let original = Cycled<`0`, `8`, Int>(7)
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == "7")
        let decoded = try JSONDecoder().decode(Cycled<`0`, `8`, Int>.self, from: encoded)
        #expect(decoded == original)
        let cycled = try JSONDecoder().decode(
            Cycled<`0`, `8`, Int>.self,
            from: try #require("9".data(using: .utf8))
        )
        #expect(cycled == Cycled<`0`, `8`, Int>(1))
    }

    @Test internal func nesting() {
        #expect(Cycled<`0`, `8`, Clamped<`0`, `100`, Int>>(109) == 4)
        #expect(Cycled<`0`, `8`, Int>(5).cycled(through: 0..<3) == 2)
    }

}


extension CycledTests {
    private typealias CarouselIndex<Count: Constant> = Cycled<`0`, Count, Int> where Count.Value == Int
    private enum `8`: Constant {
        internal static let value = 8
    }
    private enum `360.0`: Constant {
        internal static let value = 360.0
    }
    private enum `-180.0`: Constant {
        internal static let value = -180.0
    }
    private enum `180.0`: Constant {
        internal static let value = 180.0
    }
}
