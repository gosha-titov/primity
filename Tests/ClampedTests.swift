// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct ClampedTests {

    @Test internal func method() {
        #expect(150.clamped(to: 0...100) == 100)
        #expect(50.clamped(to: 0...100) == 50)
        #expect((-10).clamped(to: 0...100) == 0)
        #expect(1.5.clamped(to: 0.0...1.0) == 1.0)
        #expect(0.5.clamped(to: 0.0...1.0) == 0.5)
        #expect((-0.5).clamped(to: 0.0...1.0) == 0.0)
    }

    @Test internal func wrapper() {
        #expect(Clamped<`0`, `100`, Int>(150) == 100)
        #expect(Clamped<`0`, `100`, Int>(50) == 50)
        #expect(Clamped<`0`, `100`, Int>(-10) == 0)
        #expect(Clamped<`0.0`, `1.0`, Double>(1.5) == 1.0)
        #expect(Clamped<`0.0`, `1.0`, Double>(0.97) == 0.97)
        #expect(Clamped<`0.0`, `1.0`, Double>(-0.5) == 0.0)
    }

    @Test internal func expressing() {
        #expect(Clamped<`0`, `100`, Int>(expressing: 150) == 100)
        #expect(Clamped<`0`, `100`, Int>.expressing(150) == 100)
        #expect(Clamped<`0`, `100`, Int>(150).expressed() == 100)
    }

    @Test internal func literal() {
        let percentage: Clamped<`0`, `100`, Int> = 150
        #expect(percentage.wrapped == 100)
        let progress: Clamped<`0.0`, `1.0`, Double> = 0.97
        #expect(progress.wrapped == 0.97)
    }

    @Test internal func codable() throws {
        let original = Clamped<`0`, `100`, Int>(97)
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == "97")
        let decoded = try JSONDecoder().decode(Clamped<`0`, `100`, Int>.self, from: encoded)
        #expect(decoded == original)
        let clamped = try JSONDecoder().decode(
            Clamped<`0`, `100`, Int>.self,
            from: try #require("150".data(using: .utf8))
        )
        #expect(clamped == Clamped<`0`, `100`, Int>(100))
    }

}
