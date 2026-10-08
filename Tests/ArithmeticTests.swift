// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct ArithmeticTests {

    @Test internal func adding() throws {
        let clamped = Clamped<`0`, `100`, Int>(50)
        #expect(clamped.adding(10) == 60)
        #expect(clamped.adding(60) == 100)

        let positive = try Positive(5)
        #expect(try positive.adding(3) == 8)
        #expect(positive.adding(3)?.wrapped == 8)
        #expect(positive.adding(-5) == nil)
        #expect(throws: Positive<Int>.Error.self) {
            try positive.adding(-5)
        }
    }

    @Test internal func subtracting() throws {
        let clamped = Clamped<`0`, `100`, Int>(50)
        #expect(clamped.subtracting(10) == 40)
        #expect(clamped.subtracting(60) == 0)

        let positive = try Positive(5)
        #expect(try positive.subtracting(3) == 2)
        #expect(positive.subtracting(3)?.wrapped == 2)
        #expect(positive.subtracting(5) == nil)
        #expect(throws: Positive<Int>.Error.self) {
            try positive.subtracting(5)
        }

        let nonNegative = try NonNegative(5)
        #expect(try nonNegative.subtracting(5) == 0)
    }

    @Test internal func multiplying() throws {
        let clamped = Clamped<`0`, `100`, Int>(50)
        #expect(clamped.multiplying(by: 2) == 100)
        #expect(clamped.multiplying(by: 3) == 100)

        let positive = try Positive(5)
        #expect(try positive.multiplying(by: 2) == 10)
        #expect(positive.multiplying(by: 2)?.wrapped == 10)
        #expect(positive.multiplying(by: 0) == nil)
        #expect(positive.multiplying(by: -2) == nil)
        #expect(throws: Positive<Int>.Error.self) {
            try positive.multiplying(by: 0)
        }
    }

    @Test internal func dividing() throws {
        let progress = Clamped<`0.0`, `1.0`, Double>(0.5)
        #expect(progress.dividing(by: 2) == 0.25)
        #expect(progress.dividing(by: 0.25) == 1.0)

        let positive = try Positive(1.0)
        #expect(try positive.dividing(by: 4) == 0.25)
        #expect(positive.dividing(by: 4)?.wrapped == 0.25)
        #expect(positive.dividing(by: -2) == nil)
        #expect(throws: Positive<Double>.Error.self) {
            try positive.dividing(by: -2)
        }
    }

    @Test internal func revalidation() throws {
        let value = try Within<`0`, `100`, Int>(50)
        #expect(try value.adding(50) == 100)
        #expect(value.adding(51) == nil)
        #expect(throws: Within<`0`, `100`, Int>.Error.self) {
            try value.adding(51)
        }
    }

}
