// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper around a single value that accepts any input.
public protocol Wrapping: AnyWrapping {

    /// Creates an instance by wrapping the given value.
    init(_ value: Wrapped)

}


extension Wrapping where Wrapped: Expressible {

    /// Creates an instance by wrapping the given innermost raw value.
    @inline(__always)
    public init(expressing value: Wrapped.Expressed) {
        self.init(Wrapped(expressing: value))
    }

}
