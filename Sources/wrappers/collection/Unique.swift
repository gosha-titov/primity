// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that ensures a collection has no duplicate elements.
///
/// ## Example
/// ```
/// typealias Tags = Unique<Array<String>>
///
/// let tags: Tags? = ["swift", "ios"]        // ok
/// let invalid: Tags? = ["swift", "swift"]   // nil
/// ```
public struct Unique<Wrapped: Collection>: MaybeWrapping where Wrapped.Element: Hashable {

    /// The underlying collection, guaranteed to have no duplicate elements.
    public let wrapped: Wrapped

    /// Creates an instance by wrapping the given collection, or throws if it contains duplicates.
    public init(_ value: Wrapped) throws(Error) {
        guard Set(value).count == value.count else { throw Error(value) }
        self.wrapped = value
    }

}


extension Unique {

    /// An error thrown when a collection with duplicate elements is rejected.
    public struct Error: Swift.Error, CustomStringConvertible {

        /// The value that failed validation.
        public let value: Wrapped

        /// A description of the error.
        public var description: String {
            "Value '\(value)' must contain unique elements"
        }

        /// Creates an error for the given rejected value.
        internal init(_ value: Wrapped) {
            self.value = value
        }

    }

}


extension Unique: MaybeExpressible, AnyExpressible where Wrapped: Expressible {}

extension Unique: Sequence where Wrapped: Sequence {}
extension Unique: Collection where Wrapped: Collection {}
extension Unique: BidirectionalCollection where Wrapped: BidirectionalCollection {}

extension Unique: Codable where Wrapped: Codable {}
extension Unique: Equatable where Wrapped: Equatable {}
extension Unique: Hashable where Wrapped: Hashable {}
extension Unique: Sendable where Wrapped: Sendable {}

extension Unique.Error: Sendable where Wrapped: Sendable {}
