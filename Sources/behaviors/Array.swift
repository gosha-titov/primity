// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

extension Wrapping where Wrapped: Expressible, Wrapped.Expressed: _PrimityArray {

    /// The empty array.
    public static var empty: Self {
        return Self(expressing: [Wrapped.Expressed.Element]() as! Wrapped.Expressed)
    }

}


extension AnyWrapping where Self: AnyExpressible, Wrapped: AnyExpressible, Wrapped.Expressed: _PrimityArray {

    /// Unwraps the innermost raw array.
    @inline(__always)
    public func asArray() -> [Wrapped.Expressed.Element] {
        return expressed() as! [Wrapped.Expressed.Element]
    }

}


extension Wrapping where Self: Expressible, Wrapped: Expressible, Wrapped.Expressed: _PrimityArray {

    /// Returns a copy with the element added to the end of the innermost raw array.
    public func appending(_ newElement: Wrapped.Expressed.Element) -> Self {
        return mutated { $0.append(newElement) }
    }

    /// Returns a copy with the elements added to the end of the innermost raw array.
    public func appending<S: Sequence>(contentsOf newElements: S) -> Self where S.Element == Wrapped.Expressed.Element {
        return mutated { $0.append(contentsOf: newElements) }
    }

    /// Returns a copy with the element added at the beginning of the innermost raw array.
    public func prepending(_ newElement: Wrapped.Expressed.Element) -> Self {
        return mutated { $0.insert(newElement, at: .zero) }
    }

    /// Returns a copy with the elements added at the beginning of the innermost raw array.
    public func prepending<C: Collection>(contentsOf newElements: C) -> Self where C.Element == Wrapped.Expressed.Element {
        return mutated { $0.insert(contentsOf: newElements, at: .zero) }
    }

    /// Returns a copy with the element inserted at the specified position of the innermost raw array.
    public func inserting(_ newElement: Wrapped.Expressed.Element, at index: Int) -> Self {
        return mutated { $0.insert(newElement, at: index) }
    }

    /// Returns a copy with elements inserted at the specified position of the innermost raw array.
    public func inserting<C: Collection>(contentsOf newElements: C, at index: Int) -> Self where C.Element == Wrapped.Expressed.Element {
        return mutated { $0.insert(contentsOf: newElements, at: index) }
    }

    /// Returns a copy with the element set at the specified position of the innermost raw array.
    public func setting(_ newElement: Wrapped.Expressed.Element, at index: Int) -> Self {
        return mutated { $0[index] = newElement }
    }

    /// Returns a copy with the element removed at the specified position of the innermost raw array.
    public func removing(at index: Int) -> Self {
        return mutated { $0.remove(at: index) }
    }

    /// Returns a copy containing all elements but the specified one of the innermost raw array.
    public func removing(_ oldElement: Wrapped.Expressed.Element) -> Self where Wrapped.Expressed.Element: Equatable {
        return mutated { $0.remove(oldElement) }
    }

    /// Returns a copy containing all elements but the specified ones of the innermost raw array.
    public func removing<S: Sequence>(contentsOf oldElements: S) -> Self where S.Element == Wrapped.Expressed.Element, S.Element: Equatable {
        return mutated { $0.remove(contentsOf: oldElements) }
    }

    /// Returns a copy containing the elements of the innermost raw array except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Wrapped.Expressed.Element) throws -> Bool) rethrows -> Self {
        return try filtering { try !isRemoved($0) }
    }

    /// Returns a copy containing the elements of the innermost raw array that satisfy the given predicate.
    public func filtering(_ isIncluded: (Wrapped.Expressed.Element) throws -> Bool) rethrows -> Self {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }

    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout [Wrapped.Expressed.Element]) throws -> Void) rethrows -> Self {
        var array = asArray()
        try mutate(&array)
        return Self(expressing: array as! Wrapped.Expressed)
    }

}


extension MaybeWrapping where Self: MaybeExpressible, Wrapped: Expressible, Wrapped.Expressed: _PrimityArray {

    /// Returns a copy with the element added to the end of the innermost raw array, or throws when the new array is invalid.
    public func appending(_ newElement: Wrapped.Expressed.Element) throws -> Self {
        return try mutated { $0.append(newElement) }
    }

    /// Returns a copy with the elements added to the end of the innermost raw array, or throws when the new array is invalid.
    public func appending<S: Sequence>(contentsOf newElements: S) throws -> Self where S.Element == Wrapped.Expressed.Element {
        return try mutated { $0.append(contentsOf: newElements) }
    }

    /// Returns a copy with the element added at the beginning of the innermost raw array, or throws when the new array is invalid.
    public func prepending(_ newElement: Wrapped.Expressed.Element) throws -> Self {
        return try mutated { $0.insert(newElement, at: .zero) }
    }

    /// Returns a copy with the elements added at the beginning of the innermost raw array, or throws when the new array is invalid.
    public func prepending<C: Collection>(contentsOf newElements: C) throws -> Self where C.Element == Wrapped.Expressed.Element {
        return try mutated { $0.insert(contentsOf: newElements, at: .zero) }
    }

    /// Returns a copy with the element inserted at the specified position of the innermost raw array, or throws when the new array is invalid.
    public func inserting(_ newElement: Wrapped.Expressed.Element, at index: Int) throws -> Self {
        return try mutated { $0.insert(newElement, at: index) }
    }

    /// Returns a copy with elements inserted at the specified position of the innermost raw array, or throws when the new array is invalid.
    public func inserting<C: Collection>(contentsOf newElements: C, at index: Int) throws -> Self where C.Element == Wrapped.Expressed.Element {
        return try mutated { $0.insert(contentsOf: newElements, at: index) }
    }

    /// Returns a copy with the element set at the specified position of the innermost raw array, or throws when the new array is invalid.
    public func setting(_ newElement: Wrapped.Expressed.Element, at index: Int) throws -> Self {
        return try mutated { $0[index] = newElement }
    }

    /// Returns a copy with the element of the innermost raw array removed at the specified position, or throws when the new array is invalid.
    public func removing(at index: Int) throws -> Self {
        return try mutated { $0.remove(at: index) }
    }

    /// Returns a copy containing all elements of the innermost raw array but the specified one, or throws when the new array is invalid.
    public func removing(_ oldElement: Wrapped.Expressed.Element) throws -> Self where Wrapped.Expressed.Element: Equatable {
        return try mutated { $0.remove(oldElement) }
    }

    /// Returns a copy containing all elements of the innermost raw array but the specified ones, or throws when the new array is invalid.
    public func removing<S: Sequence>(contentsOf oldElements: S) throws -> Self where S.Element == Wrapped.Expressed.Element, S.Element: Equatable {
        return try mutated { $0.remove(contentsOf: oldElements) }
    }

    /// Returns a copy containing the elements of the innermost raw array except for those that do not satisfy the given predicate, or throws when the new array is invalid.
    public func removing(where isRemoved: (Wrapped.Expressed.Element) throws -> Bool) throws -> Self {
        return try filtering { try !isRemoved($0) }
    }

    /// Returns a copy containing the elements of the innermost raw array that satisfy the given predicate, or throws when the new array is invalid.
    public func filtering(_ isIncluded: (Wrapped.Expressed.Element) throws -> Bool) throws -> Self {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }

    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout [Wrapped.Expressed.Element]) throws -> Void) throws -> Self {
        var array = asArray()
        try mutate(&array)
        return try Self(expressing: array as! Wrapped.Expressed)
    }

}


extension MaybeWrapping where Self: MaybeExpressible, Wrapped: Expressible, Wrapped.Expressed: _PrimityArray {

    /// Returns a copy with the element added to the end of the innermost raw array, or `nil` when the new array is invalid.
    public func appending(_ newElement: Wrapped.Expressed.Element) -> Self? {
        return try? mutated { $0.append(newElement) }
    }

    /// Returns a copy with the elements added to the end of the innermost raw array, or `nil` when the new array is invalid.
    public func appending<S: Sequence>(contentsOf newElements: S) -> Self? where S.Element == Wrapped.Expressed.Element {
        return try? mutated { $0.append(contentsOf: newElements) }
    }

    /// Returns a copy with the element added at the beginning of the innermost raw array, or `nil` when the new array is invalid.
    public func prepending(_ newElement: Wrapped.Expressed.Element) -> Self? {
        return try? mutated { $0.insert(newElement, at: .zero) }
    }

    /// Returns a copy with the elements added at the beginning of the innermost raw array, or `nil` when the new array is invalid.
    public func prepending<C: Collection>(contentsOf newElements: C) -> Self? where C.Element == Wrapped.Expressed.Element {
        return try? mutated { $0.insert(contentsOf: newElements, at: .zero) }
    }

    /// Returns a copy with the element inserted at the specified position of the innermost raw array, or `nil` when the new array is invalid.
    public func inserting(_ newElement: Wrapped.Expressed.Element, at index: Int) -> Self? {
        return try? mutated { $0.insert(newElement, at: index) }
    }

    /// Returns a copy with elements inserted at the specified position of the innermost raw array, or `nil` when the new array is invalid.
    public func inserting<C: Collection>(contentsOf newElements: C, at index: Int) -> Self? where C.Element == Wrapped.Expressed.Element {
        return try? mutated { $0.insert(contentsOf: newElements, at: index) }
    }

    /// Returns a copy with the element set at the specified position of the innermost raw array, or `nil` when the new array is invalid.
    public func setting(_ newElement: Wrapped.Expressed.Element, at index: Int) -> Self? {
        return try? mutated { $0[index] = newElement }
    }

    /// Returns a copy with the element removed at the specified position of the innermost raw array, or `nil` when the new array is invalid.
    public func removing(at index: Int) -> Self? {
        return try? mutated { $0.remove(at: index) }
    }

    /// Returns a copy containing all elements of the innermost raw array but the specified one, or `nil` when the new array is invalid.
    public func removing(_ oldElement: Wrapped.Expressed.Element) -> Self? where Wrapped.Expressed.Element: Equatable {
        return try? mutated { $0.remove(oldElement) }
    }

    /// Returns a copy containing all elements of the innermost raw array but the specified ones, or `nil` when the new array is invalid.
    public func removing<S: Sequence>(contentsOf oldElements: S) -> Self? where S.Element == Wrapped.Expressed.Element, S.Element: Equatable {
        return try? mutated { $0.remove(contentsOf: oldElements) }
    }

    /// Returns a copy containing the elements of the innermost raw array except for those that do not satisfy the given predicate, or `nil` when the new array is invalid.
    public func removing(where isRemoved: (Wrapped.Expressed.Element) throws -> Bool) -> Self? {
        return filtering { try !isRemoved($0) }
    }

    /// Returns a copy containing the elements of the innermost raw array that satisfy the given predicate, or `nil` when the new array is invalid.
    public func filtering(_ isIncluded: (Wrapped.Expressed.Element) throws -> Bool) -> Self? {
        return try? mutated { $0 = try $0.filter(isIncluded) }
    }

}


/// A marker protocol identifying `Array` types.
public protocol _PrimityArray {
    associatedtype Element
}

extension Array: _PrimityArray {}
