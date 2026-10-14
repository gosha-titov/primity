// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

extension Wrapping where Wrapped: Expressible, Wrapped.Expressed: _PrimityDictionary {

    /// The empty dictionary.
    public static var empty: Self {
        return Self(expressing: [Wrapped.Expressed.Key: Wrapped.Expressed.Value]() as! Wrapped.Expressed)
    }

}


extension AnyWrapping where Self: AnyExpressible, Wrapped: AnyExpressible, Wrapped.Expressed: _PrimityDictionary {

    /// Unwraps the innermost dictionary.
    @inline(__always)
    public func asDictionary() -> [Wrapped.Expressed.Key: Wrapped.Expressed.Value] {
        return expressed() as! [Wrapped.Expressed.Key: Wrapped.Expressed.Value]
    }

}


extension Wrapping where Self: Expressible, Wrapped: Expressible, Wrapped.Expressed: _PrimityDictionary {

    /// Returns a copy with the value updated or added for the specified key within the innermost dictionary.
    public func setting(_ newValue: Wrapped.Expressed.Value, for key: Wrapped.Expressed.Key) -> Self {
        return mutated { $0[key] = newValue }
    }

    /// Returns a copy with a value removed from the innermost dictionary for the specified key.
    public func removing(for key: Wrapped.Expressed.Key) -> Self {
        return mutated { $0[key] = nil }
    }

    /// Returns a copy containing the elements of the innermost dictionary except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Dictionary<Wrapped.Expressed.Key, Wrapped.Expressed.Value>.Element) throws -> Bool) rethrows -> Self {
        return try filtering { try !isRemoved($0) }
    }

    /// Returns a copy containing the elements of the innermost dictionary that satisfy the given predicate.
    public func filtering(_ isIncluded: (Dictionary<Wrapped.Expressed.Key, Wrapped.Expressed.Value>.Element) throws -> Bool) rethrows -> Self {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }

    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout [Wrapped.Expressed.Key: Wrapped.Expressed.Value]) throws -> Void) rethrows -> Self {
        var dictionary = asDictionary()
        try mutate(&dictionary)
        return Self(expressing: dictionary as! Wrapped.Expressed)
    }

}


extension MaybeWrapping where Self: MaybeExpressible, Wrapped: Expressible, Wrapped.Expressed: _PrimityDictionary {

    /// Returns a copy with the value updated or added for the specified key within the innermost dictionary, or throws when the new dictionary is invalid.
    public func setting(_ newValue: Wrapped.Expressed.Value, for key: Wrapped.Expressed.Key) throws -> Self {
        return try mutated { $0[key] = newValue }
    }

    /// Returns a copy with a value removed from the innermost dictionary for the specified key, or throws when the new dictionary is invalid.
    public func removing(for key: Wrapped.Expressed.Key) throws -> Self {
        return try mutated { $0[key] = nil }
    }

    /// Returns a copy containing the elements of the innermost dictionary except for those that do not satisfy the given predicate, or throws when the new dictionary is invalid.
    public func removing(where isRemoved: (Dictionary<Wrapped.Expressed.Key, Wrapped.Expressed.Value>.Element) throws -> Bool) throws -> Self {
        return try filtering { try !isRemoved($0) }
    }

    /// Returns a copy containing the elements of the innermost dictionary that satisfy the given predicate, or throws when the new dictionary is invalid.
    public func filtering(_ isIncluded: (Dictionary<Wrapped.Expressed.Key, Wrapped.Expressed.Value>.Element) throws -> Bool) throws -> Self {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }

    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout [Wrapped.Expressed.Key: Wrapped.Expressed.Value]) throws -> Void) throws -> Self {
        var dictionary = asDictionary()
        try mutate(&dictionary)
        return try Self(expressing: dictionary as! Wrapped.Expressed)
    }

}


extension MaybeWrapping where Self: MaybeExpressible, Wrapped: Expressible, Wrapped.Expressed: _PrimityDictionary {

    /// Returns a copy with the value updated or added for the specified key within the innermost dictionary, or `nil` when the new dictionary is invalid.
    public func setting(_ newValue: Wrapped.Expressed.Value, for key: Wrapped.Expressed.Key) -> Self? {
        return try? mutated { $0[key] = newValue }
    }

    /// Returns a copy with a value removed from the innermost dictionary for the specified key, or `nil` when the new dictionary is invalid.
    public func removing(for key: Wrapped.Expressed.Key) -> Self? {
        return try? mutated { $0[key] = nil }
    }

    /// Returns a copy containing the elements of the innermost dictionary except for those that do not satisfy the given predicate, or `nil` when the new dictionary is invalid.
    public func removing(where isRemoved: (Dictionary<Wrapped.Expressed.Key, Wrapped.Expressed.Value>.Element) throws -> Bool) -> Self? {
        return filtering { try !isRemoved($0) }
    }

    /// Returns a copy containing the elements of the innermost dictionary that satisfy the given predicate, or `nil` when the new dictionary is invalid.
    public func filtering(_ isIncluded: (Dictionary<Wrapped.Expressed.Key, Wrapped.Expressed.Value>.Element) throws -> Bool) -> Self? {
        return try? mutated { $0 = try $0.filter(isIncluded) }
    }

}


/// A marker protocol identifying `Dictionary` types.
public protocol _PrimityDictionary {
    associatedtype Key: Hashable
    associatedtype Value
}

extension Dictionary: _PrimityDictionary {}
