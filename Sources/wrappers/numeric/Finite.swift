// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that ensures a value is finite — not `nan`, not infinite.
///
/// ## Example
/// ```
/// typealias Measurement = Finite<Double>
///
/// let measurement: Measurement? = 19.99
/// let invalid: Measurement? = .nan
/// ```
public struct Finite<Wrapped: Finitable>: MaybeWrapping {

    /// The underlying value, guaranteed to be finite.
    public let wrapped: Wrapped

    /// Creates an instance by wrapping the given value, or throws if it is `nan` or infinite.
    public init(_ value: Wrapped) throws(Error) {
        guard value.isFinite else { throw Error(value) }
        self.wrapped = value
    }

}


extension Finite {

    /// An error thrown when a non-finite value is rejected.
    public struct Error: Swift.Error, CustomStringConvertible {

        /// The value that failed validation.
        public let value: Wrapped

        /// A description of the error.
        public var description: String {
            "Value '\(value)' must be finite"
        }

        /// Creates an error for the given rejected value.
        internal init(_ value: Wrapped) {
            self.value = value
        }

    }

}


extension Finite: MaybeExpressible, AnyExpressible where Wrapped: Expressible {}

extension Finite: Codable where Wrapped: Codable {}
extension Finite: Equatable where Wrapped: Equatable {}
extension Finite: Hashable where Wrapped: Hashable {}
extension Finite: Sendable where Wrapped: Sendable {}

extension Finite.Error: Sendable where Wrapped: Sendable {}
