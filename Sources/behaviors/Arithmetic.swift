// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

extension Wrapping where Self: Expressible, Wrapped: Expressible, Wrapped.Expressed: Numeric {

    /// Returns a copy with the given number added to the innermost value.
    public func adding(_ number: Wrapped.Expressed) -> Self {
        return Self(expressing: expressed() + number)
    }

    /// Returns a copy with the given number subtracted from the innermost value.
    public func subtracting(_ number: Wrapped.Expressed) -> Self {
        return Self(expressing: expressed() - number)
    }

    /// Returns a copy with the innermost value multiplied by the given number.
    public func multiplying(by number: Wrapped.Expressed) -> Self {
        return Self(expressing: expressed() * number)
    }

}


extension MaybeWrapping where Self: MaybeExpressible, Wrapped: Expressible, Wrapped.Expressed: Numeric {

    /// Returns a copy with the given number added to the innermost value, or throws when the new value is invalid.
    public func adding(_ number: Wrapped.Expressed) throws -> Self {
        return try Self(expressing: expressed() + number)
    }

    /// Returns a copy with the given number subtracted from the innermost value, or throws when the new value is invalid.
    public func subtracting(_ number: Wrapped.Expressed) throws -> Self {
        return try Self(expressing: expressed() - number)
    }

    /// Returns a copy with the innermost value multiplied by the given number, or throws when the new value is invalid.
    public func multiplying(by number: Wrapped.Expressed) throws -> Self {
        return try Self(expressing: expressed() * number)
    }

}


extension MaybeWrapping where Self: MaybeExpressible, Wrapped: Expressible, Wrapped.Expressed: Numeric {

    /// Returns a copy with the given number added to the innermost value, or `nil` when the new value is invalid.
    public func adding(_ number: Wrapped.Expressed) -> Self? {
        return try? Self(expressing: expressed() + number)
    }

    /// Returns a copy with the given number subtracted from the innermost value, or `nil` when the new value is invalid.
    public func subtracting(_ number: Wrapped.Expressed) -> Self? {
        return try? Self(expressing: expressed() - number)
    }

    /// Returns a copy with the innermost value multiplied by the given number, or `nil` when the new value is invalid.
    public func multiplying(by number: Wrapped.Expressed) -> Self? {
        return try? Self(expressing: expressed() * number)
    }

}


extension Wrapping where Self: Expressible, Wrapped: Expressible, Wrapped.Expressed: FloatingPoint {

    /// Returns a copy with the innermost value divided by the given number.
    public func dividing(by number: Wrapped.Expressed) -> Self {
        return Self(expressing: expressed() / number)
    }

}


extension MaybeWrapping where Self: MaybeExpressible, Wrapped: Expressible, Wrapped.Expressed: FloatingPoint {

    /// Returns a copy with the underlying value divided by the given number, or throws when the new value is invalid.
    public func dividing(by number: Wrapped.Expressed) throws -> Self {
        return try Self(expressing: expressed() / number)
    }

}


extension MaybeWrapping where Self: MaybeExpressible, Wrapped: Expressible, Wrapped.Expressed: FloatingPoint {

    /// Returns a copy with the underlying value divided by the given number, or `nil` when the new value is invalid.
    public func dividing(by number: Wrapped.Expressed) -> Self? {
        return try? Self(expressing: expressed() / number)
    }

}
