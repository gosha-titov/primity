// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation

/// A type that can produce a rounded version of itself, to a multiple of a given step.
public protocol Roundable {

    /// The type used for the rounding step.
    associatedtype Step: Comparable

    /// Returns a copy rounded to a multiple of the given step, using the given rule.
    ///
    /// ## Example
    /// ```
    /// (19.999).rounded(toStep: 0.01, rule: .nearest) // 20.0
    /// ( 10.25).rounded(toStep: 0.5, rule: .up) //  10.5
    /// (-10.25).rounded(toStep: 0.5, rule: .up) // -10.5
    /// ```
    func rounded(toStep step: Step, rule: RoundingRule) -> Self

}


extension Roundable {

    /// Returns a copy rounded to a multiple of the given step.
    public func rounded(toStep step: Step) -> Self {
        return rounded(toStep: step, rule: .nearest)
    }

}


extension Wrapping where Wrapped: Roundable {

    /// Returns a copy with the wrapped value rounded to a multiple of the given step.
    @inline(__always)
    public func rounded(toStep step: Wrapped.Step, rule: RoundingRule) -> Self {
        return Self(wrapped.rounded(toStep: step, rule: rule))
    }

}


extension FloatingPoint {

    public func rounded(toStep step: Self, rule: RoundingRule) -> Self {
        guard step > .zero else { return .zero }
        return (self / step).rounded(rule.floatingPointRule) * step
    }

}


extension Decimal: Roundable {

    /// Returns a copy rounded to a multiple of the given step, using the given rule.
    ///
    /// ## Example
    /// ```
    /// Decimal(19.999).rounded(toStep: 0.01, rule: .nearest) // 20
    /// Decimal( 10.25).rounded(toStep: 0.5, rule: .up) // 10.5
    /// Decimal(-10.25).rounded(toStep: 0.5, rule: .up) // -10.5
    /// ```
    public func rounded(toStep step: Decimal, rule: RoundingRule) -> Decimal {
        guard step > .zero else { return .zero }
        var quotient = self / step
        var rounded = Decimal()
        NSDecimalRound(&rounded, &quotient, .zero, rule.decimalMode(isNegative: self < .zero))
        return rounded * step
    }

}


extension Int: Roundable {

    private var awayDirection: Int {
        return self > 0 ? 1 : -1
    }

    /// Returns a copy rounded to a multiple of the given step, using the given rule.
    ///
    /// ## Example
    /// ```
    ///  9.rounded(toStep: 8, rule: .nearest) // 8
    /// 13.rounded(toStep: 8, rule: .nearest) // 16
    ///
    /// 9.rounded(toStep: 8, rule: .up)   // 16
    /// 9.rounded(toStep: 8, rule: .down) // 8
    /// ```
    public func rounded(toStep step: Int, rule: RoundingRule) -> Int {
        precondition(step > .zero, "The rounding step must be positive")
        guard self % step != .zero else { return self }
        let quotient = self / step
        return (quotient + roundingDirection(step: step, rule: rule)) * step
    }

    private func roundingDirection(step: Int, rule: RoundingRule) -> Int {
        return switch rule {
        case .up: awayDirection
        case .down: .zero
        case .nearest: nearestDirection(step: step)
        }
    }

    private func nearestDirection(step: Int) -> Int {
        let magnitude = abs(self % step)
        let rest = step - magnitude
        guard magnitude == rest else {
            return magnitude > rest ? awayDirection : .zero
        }
        return awayDirection
    }

}


extension Clamped: Roundable where Wrapped: Roundable {}
extension Cycled: Roundable where Wrapped: Roundable {}
extension RoundedWith: Roundable where Wrapped: Roundable {}

extension Double: Roundable {}
extension Float: Roundable {}
