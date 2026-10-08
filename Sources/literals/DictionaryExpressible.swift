// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A type that can be initialized with a dictionary value.
public protocol DictionaryExpressible: ExpressibleByDictionaryLiteral where Key: Hashable {

    /// The key type of a dictionary literal.
    associatedtype Key

    /// The value type of a dictionary literal.
    associatedtype Value

    /// Creates an instance from the dictionary.
    init(dictionary: [Key: Value])

}


extension Wrapping where Wrapped: DictionaryExpressible {

    public init(dictionaryLiteral elements: (Wrapped.Key, Wrapped.Value)...) {
        self.init(dictionary: Dictionary(elements) { _, second in second })
    }

    public init(dictionary: [Wrapped.Key: Wrapped.Value]) {
        self.init(Wrapped(dictionary: dictionary))
    }

}


extension Optional: @retroactive ExpressibleByDictionaryLiteral where Wrapped: MaybeExpressible, Wrapped.Expressed: DictionaryExpressible {

    public init(dictionaryLiteral elements: (Wrapped.Expressed.Key, Wrapped.Expressed.Value)...) {
        self = Wrapped(expressing: Wrapped.Expressed(dictionary: Dictionary(elements) { _, second in second }))
    }

}


extension Dictionary: DictionaryExpressible {

    public init(dictionary: [Key: Value]) {
        self = dictionary
    }

}
