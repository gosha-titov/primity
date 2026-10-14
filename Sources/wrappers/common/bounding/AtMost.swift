// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that ensures a value is not above an upper bound.
/// 
/// ## Example
/// ```
/// typealias Attachments = AtMost<`5`, Array<Attachment>>
///
/// let attachments: Attachments? = files
/// ```
public struct AtMost<UpperBound: Constant, Wrapped: Withinable>: MaybeWrapping where UpperBound.Value == Wrapped.Bound {

    /// The underlying value, guaranteed to be at most the bound.
    public let wrapped: Wrapped

    /// Creates an instance by wrapping the given value, or throws if it is above the bound.
    public init(_ value: Wrapped) throws(Error) {
        guard value.isWithin(...UpperBound.value) else { throw Error(value) }
        self.wrapped = value
    }

}


extension AtMost {

    /// An error thrown when a value above the bound is rejected.
    public struct Error: Swift.Error, CustomStringConvertible {

        /// The value that failed validation.
        public let value: Wrapped

        /// A description of the error.
        public var description: String {
            "Value '\(value)' must be at most \(UpperBound.value)"
        }

        /// Creates an error for the given rejected value.
        internal init(_ value: Wrapped) {
            self.value = value
        }

    }

}


extension AtMost: MaybeExpressible, AnyExpressible where Wrapped: Expressible {}

extension AtMost: Sequence where Wrapped: Sequence {}
extension AtMost: Collection where Wrapped: Collection {}
extension AtMost: BidirectionalCollection where Wrapped: BidirectionalCollection {}

extension AtMost: Codable where Wrapped: Codable {}
extension AtMost: Equatable where Wrapped: Equatable {}
extension AtMost: Hashable where Wrapped: Hashable {}
extension AtMost: Sendable where Wrapped: Sendable {}

extension AtMost.Error: Sendable where Wrapped: Sendable {}
