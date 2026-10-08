// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

extension AnyWrapping where Self: AnyExpressible, Wrapped: AnyExpressible, Wrapped.Expressed: _PrimitySet {

    /// Unwraps the innermost set.
    @inline(__always)
    public func asSet() -> Set<Wrapped.Expressed.Element> {
        return expressed() as! Set<Wrapped.Expressed.Element>
    }

}


extension Wrapping where Self: Expressible, Wrapped: Expressible, Wrapped.Expressed: _PrimitySet {

    /// Returns a copy with the element inserted into the innermost set.
    public func inserting(_ newElement: Wrapped.Expressed.Element) -> Self {
        return mutated { $0.insert(newElement) }
    }

    /// Returns a copy with the elements inserted into the innermost set.
    public func inserting<S: Sequence>(contentsOf newElements: S) -> Self where S.Element == Wrapped.Expressed.Element {
        return mutated { $0 = $0.union(newElements) }
    }

    /// Returns a copy with the element removed from the innermost set.
    public func removing(_ oldElement: Wrapped.Expressed.Element) -> Self {
        return mutated { $0.remove(oldElement) }
    }

    /// Returns a copy with the elements removed from the innermost set.
    public func removing<S: Sequence>(contentsOf oldElement: S) -> Self where S.Element == Wrapped.Expressed.Element {
        return mutated { $0.subtract(oldElement) }
    }

    /// Returns a copy containing the elements of the innermost set except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Wrapped.Expressed.Element) throws -> Bool) rethrows -> Self {
        return try filtering { try !isRemoved($0) }
    }

    /// Returns a copy containing the elements of the innermost set that satisfy the given predicate.
    public func filtering(_ isIncluded: (Wrapped.Expressed.Element) throws -> Bool) rethrows -> Self {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }

    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout Set<Wrapped.Expressed.Element>) throws -> Void) rethrows -> Self {
        var set = asSet()
        try mutate(&set)
        return Self(expressing: set as! Wrapped.Expressed)
    }

}


extension MaybeWrapping where Self: MaybeExpressible, Wrapped: Expressible, Wrapped.Expressed: _PrimitySet {

    /// Returns a copy with the element inserted into the innermost set, or throws when the new set is invalid.
    public func inserting(_ newElement: Wrapped.Expressed.Element) throws -> Self {
        return try mutated { $0.insert(newElement) }
    }

    /// Returns a copy with the elements inserted into the innermost set, or throws when the new set is invalid.
    public func inserting<S: Sequence>(contentsOf newElements: S) throws -> Self where S.Element == Wrapped.Expressed.Element {
        return try mutated { $0 = $0.union(newElements) }
    }

    /// Returns a copy with the element removed from the innermost set, or throws when the new set is invalid.
    public func removing(_ oldElement: Wrapped.Expressed.Element) throws -> Self {
        return try mutated { $0.remove(oldElement) }
    }

    /// Returns a copy with the elements removed from the innermost set, or throws when the new set is invalid.
    public func removing<S: Sequence>(contentsOf oldElement: S) throws -> Self where S.Element == Wrapped.Expressed.Element {
        return try mutated { $0.subtract(oldElement) }
    }

    /// Returns a copy containing the elements of the innermost set except for those that do not satisfy the given predicate, or throws when the new set is invalid.
    public func removing(where isRemoved: (Wrapped.Expressed.Element) throws -> Bool) throws -> Self {
        return try filtering { try !isRemoved($0) }
    }

    /// Returns a copy containing the elements of the innermost set that satisfy the given predicate, or throws when the new set is invalid.
    public func filtering(_ isIncluded: (Wrapped.Expressed.Element) throws -> Bool) throws -> Self {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }

    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout Set<Wrapped.Expressed.Element>) throws -> Void) throws -> Self {
        var set = asSet()
        try mutate(&set)
        return try Self(expressing: set as! Wrapped.Expressed)
    }

}


extension MaybeWrapping where Self: MaybeExpressible, Wrapped: Expressible, Wrapped.Expressed: _PrimitySet {

    /// Returns a copy with the element inserted into the innermost set, or `nil` when the new set is invalid.
    public func inserting(_ newElement: Wrapped.Expressed.Element) -> Self? {
        return try? mutated { $0.insert(newElement) }
    }

    /// Returns a copy with the elements inserted into the innermost set, or `nil` when the new set is invalid.
    public func inserting<S: Sequence>(contentsOf newElements: S) -> Self? where S.Element == Wrapped.Expressed.Element {
        return try? mutated { $0 = $0.union(newElements) }
    }

    /// Returns a copy with the element removed from the innermost set, or `nil` when the new set is invalid.
    public func removing(_ oldElement: Wrapped.Expressed.Element) -> Self? {
        return try? mutated { $0.remove(oldElement) }
    }

    /// Returns a copy with the elements removed from the innermost set, or `nil` when the new set is invalid.
    public func removing<S: Sequence>(contentsOf oldElement: S) -> Self? where S.Element == Wrapped.Expressed.Element {
        return try? mutated { $0.subtract(oldElement) }
    }

    /// Returns a copy containing the elements of the innermost set except for those that do not satisfy the given predicate, or `nil` when the new set is invalid.
    public func removing(where isRemoved: (Wrapped.Expressed.Element) throws -> Bool) -> Self? {
        return filtering { try !isRemoved($0) }
    }

    /// Returns a copy containing the elements of the innermost set that satisfy the given predicate, or `nil` when the new set is invalid.
    public func filtering(_ isIncluded: (Wrapped.Expressed.Element) throws -> Bool) -> Self? {
        return try? mutated { $0 = try $0.filter(isIncluded) }
    }

}


/// A marker protocol identifying `Set` types.
public protocol _PrimitySet {
    associatedtype Element: Hashable
}

extension Set: _PrimitySet {}
