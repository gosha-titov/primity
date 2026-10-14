// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that cycles its value through a range on creation.
///
/// Where `Clamped` stops at the bound, `Cycled` walks through it and comes
/// back around. The upper bound is excluded: a value equal to it wraps to
/// the lower bound. This makes `Cycled` a natural fit for circular
/// quantities — carousel pages, angles, weekdays.
///
/// ## Example 1
/// ```
/// typealias CarouselIndex<Count: Constant> = Cycled<`0`, Count, Int>
///     where Count.Value == Int
///
/// let index: CarouselIndex<`10`> = 11
/// // 1
/// ```
///
/// ## Example 2
/// ```
/// typealias Hue = Cycled<`0.0`, `360.0`, Double>
///
/// let hue: Hue = 370.0
/// // 10.0
/// ```
public struct Cycled<LowerBound: Constant, UpperBound: Constant, Wrapped: Cyclable>: Wrapping where LowerBound.Value == UpperBound.Value, LowerBound.Value == Wrapped.Bound {

    /// The underlying cycled value.
    public let wrapped: Wrapped

    /// Creates an instance by cycling the given value through the bounds.
    public init(_ value: Wrapped) {
        let bounds = LowerBound.value..<UpperBound.value
        self.wrapped = value.cycled(through: bounds)
    }

}


extension Cycled: Expressible, AnyExpressible where Wrapped: Expressible {}

extension Cycled: Codable where Wrapped: Codable {}
extension Cycled: Comparable where Wrapped: Comparable {}
extension Cycled: Equatable where Wrapped: Equatable {}
extension Cycled: Hashable where Wrapped: Hashable {}
extension Cycled: Sendable where Wrapped: Sendable {}

extension Cycled: ExpressibleByFloatLiteral where Wrapped: ExpressibleByFloatLiteral {}
extension Cycled: ExpressibleByIntegerLiteral where Wrapped: ExpressibleByIntegerLiteral {}
