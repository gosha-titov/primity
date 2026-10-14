// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

extension Wrapping where Wrapped: Expressible, Wrapped.Expressed == String {

    /// The empty string.
    public static var empty: Self {
        return Self(expressing: .empty)
    }

}


extension AnyWrapping where Self: AnyExpressible, Expressed == String {

    /// Unwraps the innermost string.
    @inline(__always)
    public func asString() -> String {
        return expressed()
    }

}


extension Wrapping where Self: Expressible, Expressed == String {

    /// Returns a copy with the character added to the end of the innermost string.
    public func appending(_ newCharacter: Character) -> Self {
        return mutated { $0.append(newCharacter) }
    }

    /// Returns a copy with the characters added to the end of the innermost string.
    public func appending<S: Sequence>(contentsOf newCharacters: S) -> Self where S.Element == Character {
        return mutated { $0.append(contentsOf: newCharacters) }
    }

    /// Returns a copy with the character added at the beginning of the innermost string.
    public func prepending(_ newCharacter: Character) -> Self {
        return mutated { $0.insert(newCharacter, at: $0.startIndex) }
    }

    /// Returns a copy with the characters added at the beginning of the innermost string.
    public func prepending<C: Collection>(contentsOf newCharacters: C) -> Self where C.Element == Character {
        return mutated { $0.insert(contentsOf: newCharacters, at: $0.startIndex) }
    }

    /// Returns a copy with the character inserted at the specified position of the innermost string.
    public func inserting(_ newCharacter: Character, at index: String.Index) -> Self {
        return mutated { $0.insert(newCharacter, at: index) }
    }

    /// Returns a copy with the characters inserted at the specified position of the innermost string.
    public func inserting<C: Collection>(contentsOf newCharacters: C, at index: String.Index) -> Self where C.Element == Character {
        return mutated { $0.insert(contentsOf: newCharacters, at: index) }
    }

    /// Returns a copy with the character removed at the specified position of the innermost string.
    public func removing(at index: String.Index) -> Self {
        return mutated { $0.remove(at: index) }
    }

    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout String) throws -> Void) rethrows -> Self {
        var string = asString()
        try mutate(&string)
        return Self(expressing: string)
    }

}


extension MaybeWrapping where Self: MaybeExpressible, Expressed == String {

    /// Returns a copy with the character added to the end of the innermost string, or throws when the new string is invalid.
    public func appending(_ newCharacter: Character) throws -> Self {
        return try mutated { $0.append(newCharacter) }
    }

    /// Returns a copy with the characters added to the end of the innermost string, or throws when the new string is invalid.
    public func appending<S: Sequence>(contentsOf newCharacters: S) throws -> Self where S.Element == Character {
        return try mutated { $0.append(contentsOf: newCharacters) }
    }

    /// Returns a copy with the character added at the beginning of the innermost string, or throws when the new string is invalid.
    public func prepending(_ newCharacter: Character) throws -> Self {
        return try mutated { $0.insert(newCharacter, at: $0.startIndex) }
    }

    /// Returns a copy with the characters added at the beginning of the innermost string, or throws when the new string is invalid.
    public func prepending<C: Collection>(contentsOf newCharacters: C) throws -> Self where C.Element == Character {
        return try mutated { $0.insert(contentsOf: newCharacters, at: $0.startIndex) }
    }

    /// Returns a copy with the character inserted at the specified position of the innermost string, or throws when the new string is invalid.
    public func inserting(_ newCharacter: Character, at index: String.Index) throws -> Self {
        return try mutated { $0.insert(newCharacter, at: index) }
    }

    /// Returns a copy with the characters inserted at the specified position of the innermost string, or throws when the new string is invalid.
    public func inserting<C: Collection>(contentsOf newCharacters: C, at index: String.Index) throws -> Self where C.Element == Character {
        return try mutated { $0.insert(contentsOf: newCharacters, at: index) }
    }

    /// Returns a copy with the character removed at the specified position of the innermost string, or throws when the new string is invalid.
    public func removing(at index: String.Index) throws -> Self {
        return try mutated { $0.remove(at: index) }
    }

    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout String) throws -> Void) throws -> Self {
        var string = asString()
        try mutate(&string)
        return try Self(expressing: string)
    }

}


extension MaybeWrapping where Self: MaybeExpressible, Expressed == String {

    /// Returns a copy with the character added to the end of the innermost string, or `nil` when the new string is invalid.
    public func appending(_ newCharacter: Character) -> Self? {
        return try? mutated { $0.append(newCharacter) }
    }

    /// Returns a copy with the characters added to the end of the innermost string, or `nil` when the new string is invalid.
    public func appending<S: Sequence>(contentsOf newCharacters: S) -> Self? where S.Element == Character {
        return try? mutated { $0.append(contentsOf: newCharacters) }
    }

    /// Returns a copy with the character added at the beginning of the innermost string, or `nil` when the new string is invalid.
    public func prepending(_ newCharacter: Character) -> Self? {
        return try? mutated { $0.insert(newCharacter, at: $0.startIndex) }
    }

    /// Returns a copy with the characters added at the beginning of the innermost string, or `nil` when the new string is invalid.
    public func prepending<C: Collection>(contentsOf newCharacters: C) -> Self? where C.Element == Character {
        return try? mutated { $0.insert(contentsOf: newCharacters, at: $0.startIndex) }
    }

    /// Returns a copy with the character inserted at the specified position of the innermost string, or `nil` when the new string is invalid.
    public func inserting(_ newCharacter: Character, at index: String.Index) -> Self? {
        return try? mutated { $0.insert(newCharacter, at: index) }
    }

    /// Returns a copy with the characters inserted at the specified position of the innermost string, or `nil` when the new string is invalid.
    public func inserting<C: Collection>(contentsOf newCharacters: C, at index: String.Index) -> Self? where C.Element == Character {
        return try? mutated { $0.insert(contentsOf: newCharacters, at: index) }
    }

    /// Returns a copy with the character removed at the specified position of the innermost string, or `nil` when the new string is invalid.
    public func removing(at index: String.Index) -> Self? {
        return try? mutated { $0.remove(at: index) }
    }

}
