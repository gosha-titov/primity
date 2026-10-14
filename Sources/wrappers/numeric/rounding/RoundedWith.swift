// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that rounds its value on creation, using the given rounding rule.
///
/// The value is rounded to a multiple of the given step during initialization.
/// The step is expressed in the value's own unit: `0.01` for cents, `0.5`
/// for half steps, `1.0` for whole numbers. Prefer the convenience forms —
/// `Rounded`, `RoundedUp`, `RoundedDown` — and use this one when you need
/// an explicit rule.
///
/// ## Example
/// ```
/// typealias Price = Positive<RoundedWith<`0.01`, RoundingRule.Nearest, Double>>
///
/// let price: Price? = 19.999
/// // 20.0
/// ```
public struct RoundedWith<Step: Constant, Rule: Constant, Wrapped: Roundable>: Wrapping where Step.Value == Wrapped.Step, Rule.Value == RoundingRule {

    /// The underlying rounded value.
    public let wrapped: Wrapped

    /// Creates an instance by rounding the given value to a multiple of the given step.
    public init(_ value: Wrapped) {
        self.wrapped = value.rounded(toStep: Step.value, rule: Rule.value)
    }

}


/// A wrapper that rounds its value on creation — to the nearest multiple, ties away from zero.
///
/// Schoolbook rounding, the default rule.
///
/// ## Example
/// ```
/// typealias Price = Positive<Rounded<`0.01`, Double>>
///
/// let price: Price? = 19.999
/// // 20.0
/// ```
public typealias Rounded<Step: Constant, Wrapped: Roundable> = RoundedWith<Step, RoundingRule.Nearest, Wrapped> where Step.Value == Wrapped.Step

/// A wrapper that rounds its value up on creation — away from zero.
///
/// ## Example
/// ```
/// typealias Fee = RoundedUp<`0.01`, Double>
///
/// let fee: Fee = 10.251
/// // 10.26
/// ```
public typealias RoundedUp<Step: Constant, Wrapped: Roundable> = RoundedWith<Step, RoundingRule.Up, Wrapped> where Step.Value == Wrapped.Step

/// A wrapper that rounds its value down on creation — toward zero (truncation).
///
/// ## Example
/// ```
/// typealias DisplayedRating = RoundedDown<`0.1`, Double>
///
/// let rating: DisplayedRating = 4.99
/// // 4.9
/// ```
public typealias RoundedDown<Step: Constant, Wrapped: Roundable> = RoundedWith<Step, RoundingRule.Down, Wrapped> where Step.Value == Wrapped.Step


extension RoundedWith: Expressible, AnyExpressible where Wrapped: Expressible {}

extension RoundedWith: Codable where Wrapped: Codable {}
extension RoundedWith: Comparable where Wrapped: Comparable {}
extension RoundedWith: Equatable where Wrapped: Equatable {}
extension RoundedWith: Hashable where Wrapped: Hashable {}
extension RoundedWith: Sendable where Wrapped: Sendable {}

extension RoundedWith: ExpressibleByFloatLiteral where Wrapped: ExpressibleByFloatLiteral {}
extension RoundedWith: ExpressibleByIntegerLiteral where Wrapped: ExpressibleByIntegerLiteral {}
