// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A type that converts to and from a raw value.
///
/// This protocol sits at the root of the expressible hierarchy,
/// refined by `Expressible` and `MaybeExpressible`.
public protocol AnyExpressible {

    /// The type of the raw value.
    associatedtype Expressed = Self

    /// Returns a raw value.
    func expressed() -> Expressed

}


extension AnyExpressible where Expressed == Self {

    /// Returns the value itself.
    @_transparent
    public func expressed() -> Self {
        return self
    }

}
