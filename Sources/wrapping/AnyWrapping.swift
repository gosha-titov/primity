// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper around a single value.
///
/// Conforming types expose a single underlying value via the `wrapped` property.
/// - Important: All implementations are expected to be immutable.
public protocol AnyWrapping: CustomStringConvertible {

    /// The type of the underlying value.
    associatedtype Wrapped

    /// The underlying value.
    var wrapped: Wrapped { get }

}


extension AnyWrapping {

    /// The textual representation of the wrapped value.
    @inline(__always)
    public var description: String {
        return "\(wrapped)"
    }

}


extension AnyWrapping where Wrapped: AnyExpressible {

    /// The type of the innermost raw value.
    public typealias Expressed = Wrapped.Expressed

    /// Returns the raw value of the innermost layer.
    @_transparent
    public func expressed() -> Wrapped.Expressed {
        return wrapped.expressed()
    }

}
