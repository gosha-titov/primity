// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A type that can be checked against a range.
public protocol Withinable {

    /// The type used for range boundaries.
    associatedtype Bound: Comparable

    /// Returns `true` if the instance falls within the given range.
    ///
    /// Any range expression works: closed (`a...b`), partial (`a...`, `...b`), or open (`a..<b`).
    func isWithin<R: RangeExpression>(_ range: R) -> Bool where R.Bound == Bound

}


extension Wrapping where Wrapped: Withinable {

    @_transparent
    public func isWithin<R: RangeExpression>(_ range: R) -> Bool where R.Bound == Wrapped.Bound {
        return wrapped.isWithin(range)
    }

}


extension Clamped: Withinable where Wrapped: Withinable {
    public typealias Bound = Wrapped.Bound
}

extension Cycled: Withinable where Wrapped: Withinable {
    public typealias Bound = Wrapped.Bound
}

extension RoundedWith: Withinable where Wrapped: Withinable {
    public typealias Bound = Wrapped.Bound
}


extension Array: Withinable {
    public typealias Bound = Int
    public func isWithin<R: RangeExpression>(_ range: R) -> Bool where R.Bound == Int {
        return range.contains(count)
    }
}

extension String: Withinable {
    public typealias Bound = Int
    public func isWithin<R: RangeExpression>(_ range: R) -> Bool where R.Bound == Int {
        return range.contains(count)
    }
}

extension Set: Withinable {
    public typealias Bound = Int
    public func isWithin<R: RangeExpression>(_ range: R) -> Bool where R.Bound == Int {
        return range.contains(count)
    }
}

extension Dictionary: Withinable {
    public typealias Bound = Int
    public func isWithin<R: RangeExpression>(_ range: R) -> Bool where R.Bound == Int {
        return range.contains(count)
    }
}

extension Int: Withinable {
    public typealias Bound = Int
    public func isWithin<R: RangeExpression>(_ range: R) -> Bool where R.Bound == Int {
        return range.contains(self)
    }
}

extension Double: Withinable {
    public typealias Bound = Double
    public func isWithin<R: RangeExpression>(_ range: R) -> Bool where R.Bound == Double {
        return range.contains(self)
    }
}

extension Float: Withinable {
    public typealias Bound = Float
    public func isWithin<R: RangeExpression>(_ range: R) -> Bool where R.Bound == Float {
        return range.contains(self)
    }
}
