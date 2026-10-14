// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A type that can indicate whether it is positive.
public protocol Positivable {

    /// A boolean value indicating whether the instance is positive.
    var isPositive: Bool { get }

}


extension Wrapping where Wrapped: Positivable {

    @_transparent
    public var isPositive: Bool {
        return wrapped.isPositive
    }

}


extension RoundedWith: Positivable where Wrapped: Positivable {}


extension Double: Positivable {
    public var isPositive: Bool {
        return self > .zero
    }
}

extension Float: Positivable {
    public var isPositive: Bool {
        return self > .zero
    }
}

extension Int: Positivable {
    public var isPositive: Bool {
        return self > .zero
    }
}
