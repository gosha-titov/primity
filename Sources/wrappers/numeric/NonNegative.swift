// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that ensures a value is non-negative.
///
/// ## Example
/// ```
/// typealias PlayerLevel = NonNegative<Double>
///
/// let level: PlayerLevel? = 48.27
/// ```
public struct NonNegative<Wrapped>: MaybeWrapping where Wrapped: Negativable {

    /// The underlying non‑negative value.
    public let wrapped: Wrapped

    /// Creates an instance by wrapping the given value, or throws if the value is negative.
    public init(_ value: Wrapped) throws(Error) {
        guard !value.isNegative else { throw Error(value) }
        self.wrapped = value
    }

}


extension NonNegative {

    /// An error thrown when a negative value is rejected.
    public struct Error: Swift.Error, CustomStringConvertible {

        /// The value that failed validation.
        public let value: Wrapped

        /// A description of the error.
        public var description: String {
            "Value '\(value)' must not be negative"
        }

        /// Creates an error for the given rejected value.
        internal init(_ value: Wrapped) {
            self.value = value
        }

    }

}


extension NonNegative: MaybeExpressible, AnyExpressible where Wrapped: Expressible {}

extension NonNegative: Codable where Wrapped: Codable {}
extension NonNegative: Comparable where Wrapped: Comparable {}
extension NonNegative: Equatable where Wrapped: Equatable {}
extension NonNegative: Hashable where Wrapped: Hashable {}
extension NonNegative: Sendable where Wrapped: Sendable {}

extension NonNegative.Error: Sendable where Wrapped: Sendable {}
