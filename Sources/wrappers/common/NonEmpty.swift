// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that ensures a value is non-empty.
///
/// ## Example
/// ```
/// typealias Title = NonEmpty<String>
///
/// let title: Title? = "Swift Development"
/// ```
public struct NonEmpty<Wrapped>: MaybeWrapping where Wrapped: Emptyable {

    /// The underlying non‑empty value.
    public let wrapped: Wrapped

    /// Creates an instance by wrapping the given value, or throws if the value is empty.
    public init(_ value: Wrapped) throws(Error) {
        guard !value.isEmpty else { throw Error() }
        self.wrapped = value
    }

}


extension NonEmpty {

    /// An error thrown when a empty value is rejected.
    public struct Error: Swift.Error, CustomStringConvertible {

        /// A description of the error.
        public var description: String {
            "Value must not be empty"
        }

    }

}


extension NonEmpty {

    /// Creates an instance by wrapping the given value, or returns `nil` if the value doesn't exist or empty.
    public init?(_ value: Wrapped?) {
        guard let value, !value.isEmpty else { return nil }
        self.wrapped = value
    }

}


extension NonEmpty where Wrapped: Expressible {

    /// Creates an instance from the given raw value, or returns `nil` if the value doesn't exist or empty.
    public static func expressing(_ value: Expressed?) -> Self? {
        return Self(expressing: value)
    }

    /// Creates an instance from the given raw value, or returns `nil` if the value doesn't exist or empty.
    public init?(expressing value: Wrapped.Expressed?) {
        guard let value else { return nil }
        guard let wrapper = Self(expressing: value) else { return nil }
        self = wrapper
    }

}


extension NonEmpty where Wrapped: Expressible, Wrapped.Expressed == String {

    /// Creates a non-empty wrapper containing a single character.
    ///
    /// ## Example
    /// ```
    /// typealias Letters = NonEmpty<String>
    ///
    /// let letters = Letters.single("f")
    /// ```
    public static func single(_ element: Character) -> Self {
        return NonEmpty(expressing: String(element))!
    }

}


extension NonEmpty where Wrapped: Expressible, Wrapped.Expressed: _PrimityArray {

    /// Creates a non-empty wrapper containing a single element.
    ///
    /// ## Example
    /// ```
    /// typealias Numbers = NonEmpty<Array<Int>>
    ///
    /// let numbers = Numbers.single(10)
    /// ```
    public static func single(_ element: Expressed.Element) -> Self {
        return NonEmpty(expressing: [element] as! Expressed)!
    }

}


extension NonEmpty where Wrapped: Expressible, Wrapped.Expressed: _PrimitySet {

    /// Creates a non-empty wrapper containing a single element.
    ///
    /// ## Example
    /// ```
    /// typealias Numbers = NonEmpty<Set<Int>>
    ///
    /// let numbers = Numbers.single(10)
    /// ```
    public static func single(_ element: Expressed.Element) -> Self {
        return NonEmpty(expressing: Set([element]) as! Expressed)!
    }

}


extension NonEmpty where Wrapped: Expressible, Wrapped.Expressed: _PrimityDictionary {

    /// Creates a non-empty wrapper containing a single key-value pair.
    ///
    /// ## Example
    /// ```
    /// typealias Greetings = NonEmpty<Dictionary<Stirng, String>>
    ///
    /// let greetings = Greetings.single("Hello", for: "en")
    /// ```
    public static func single(_ value: Expressed.Value, for key: Expressed.Key) -> Self {
        return NonEmpty(expressing: [key: value] as! Expressed)!
    }

}


extension NonEmpty where Wrapped: Collection {

    /// The first element of the underlying collection.
    public var first: Wrapped.Element {
        return wrapped.first!
    }

    /// Returns a random element of the underlying collection.
    public func random() -> Wrapped.Element {
        return wrapped.randomElement()!
    }

}

extension NonEmpty where Wrapped: BidirectionalCollection {

    /// The last element of the underlying collection.
    public var last: Wrapped.Element {
        return wrapped.last!
    }

}


extension NonEmpty where Wrapped: Collection, Wrapped.Element: Comparable {

    /// Returns the maximum element in the underlying sequence.
    public func max() -> Wrapped.Element {
        return wrapped.max()!
    }

    /// Returns the minimum element in the underlying sequence.
    public func min() -> Wrapped.Element {
        return wrapped.min()!
    }

}


extension NonEmpty: MaybeExpressible, AnyExpressible where Wrapped: Expressible {}

extension NonEmpty: Codable where Wrapped: Codable {}
extension NonEmpty: Comparable where Wrapped: Comparable {}
extension NonEmpty: Equatable where Wrapped: Equatable {}
extension NonEmpty: Hashable where Wrapped: Hashable {}
extension NonEmpty: Sendable where Wrapped: Sendable {}

extension NonEmpty: Sequence where Wrapped: Sequence {}
extension NonEmpty: Collection where Wrapped: Collection {}
extension NonEmpty: BidirectionalCollection where Wrapped: BidirectionalCollection {}

extension NonEmpty.Error: Sendable where Wrapped: Sendable {}
