// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that ensures a value is not below a lower bound.
/// 
/// ## Example
/// ```
/// typealias Password = AtLeast<`4`, String>
///
/// let password: Password? = "secret"
/// ```
public struct AtLeast<LowerBound: Constant, Wrapped: Withinable>: MaybeWrapping where LowerBound.Value == Wrapped.Bound {

    /// The underlying value, guaranteed to be at least the bound.
    public let wrapped: Wrapped

    /// Creates an instance by wrapping the given value, or throws if it is below the bound.
    public init(_ value: Wrapped) throws(Error) {
        guard value.isWithin(LowerBound.value...) else { throw Error(value) }
        self.wrapped = value
    }

}


extension AtLeast {

    /// An error thrown when a value below the bound is rejected.
    public struct Error: Swift.Error, CustomStringConvertible {

        /// The value that failed validation.
        public let value: Wrapped

        /// A description of the error.
        public var description: String {
            "Value '\(value)' must be at least \(LowerBound.value)"
        }

        /// Creates an error for the given rejected value.
        internal init(_ value: Wrapped) {
            self.value = value
        }

    }

}


extension AtLeast: MaybeExpressible, AnyExpressible where Wrapped: Expressible {}

extension AtLeast: Sequence where Wrapped: Sequence {}
extension AtLeast: Collection where Wrapped: Collection {}
extension AtLeast: BidirectionalCollection where Wrapped: BidirectionalCollection {}

extension AtLeast: Codable where Wrapped: Codable {}
extension AtLeast: Equatable where Wrapped: Equatable {}
extension AtLeast: Hashable where Wrapped: Hashable {}
extension AtLeast: Sendable where Wrapped: Sendable {}

extension AtLeast.Error: Sendable where Wrapped: Sendable {}
