// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A type that can be cycled through a range, wrapping around its bounds.
public protocol Cyclable {

    /// The type used for range boundaries.
    associatedtype Bound: Comparable

    /// Returns a copy cycled through the given bounds, wrapping around them.
    ///
    /// The upper bound is excluded: a value reaching it wraps to the lower bound.
    func cycled(through bounds: Range<Bound>) -> Self

}


extension Wrapping where Wrapped: Cyclable {

    /// Returns a copy with the wrapped value cycled through the given bounds.
    @inline(__always)
    public func cycled(through bounds: Range<Wrapped.Bound>) -> Self {
        return Self(wrapped.cycled(through: bounds))
    }

}


extension Int: Cyclable {

    /// Returns a copy cycled through the given bounds.
    ///
    /// ## Example
    /// ```
    /// let bounds = 0..<8
    /// 7.cycled(through: bounds)   // 7
    /// 9.cycled(through: bounds)   // 1
    /// (-1).cycled(through: bounds) // 7
    /// ```
    public func cycled(through bounds: Range<Int>) -> Int {
        let span = bounds.upperBound - bounds.lowerBound
        precondition(span > 0, "The cycle bounds must not be empty")
        let offset = (self - bounds.lowerBound) % span
        return bounds.lowerBound + (offset >= 0 ? offset : offset + span)
    }

}


extension Double: Cyclable {

    /// Returns a copy cycled through the given bounds.
    ///
    /// ## Example
    /// ```
    /// let bounds = 0.0..<360.0
    /// 350.0.cycled(through: bounds)   // 350.0
    /// 370.0.cycled(through: bounds)   // 10.0
    /// (-10.0).cycled(through: bounds) // 350.0
    /// ```
    public func cycled(through bounds: Range<Double>) -> Double {
        let span = bounds.upperBound - bounds.lowerBound
        precondition(span > 0, "The cycle bounds must not be empty")
        let offset = (self - bounds.lowerBound).truncatingRemainder(dividingBy: span)
        return bounds.lowerBound + (offset >= 0 ? offset : offset + span)
    }

}


extension Float: Cyclable {

    /// Returns a copy cycled through the given bounds.
    public func cycled(through bounds: Range<Float>) -> Float {
        let span = bounds.upperBound - bounds.lowerBound
        precondition(span > 0, "The cycle bounds must not be empty")
        let offset = (self - bounds.lowerBound).truncatingRemainder(dividingBy: span)
        return bounds.lowerBound + (offset >= 0 ? offset : offset + span)
    }

}


extension Clamped: Cyclable where Wrapped: Cyclable {}
extension Cycled: Cyclable where Wrapped: Cyclable {}
