// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A type that can indicate whether it is negative.
public protocol Negativable {

    /// A boolean value indicating whether the instance is negative.
    var isNegative: Bool { get }

}


extension Wrapping where Wrapped: Negativable {

    @_transparent
    public var isNegative: Bool {
        return wrapped.isNegative
    }

}


extension RoundedWith: Negativable where Wrapped: Negativable {}


extension Double: Negativable {
    public var isNegative: Bool {
        return self < .zero
    }
}

extension Float: Negativable {
    public var isNegative: Bool {
        return self < .zero
    }
}

extension Int: Negativable {
    public var isNegative: Bool {
        return self < .zero
    }
}
