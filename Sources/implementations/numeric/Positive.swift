// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that ensures a value is positive.
///
/// ## Example
/// ```
/// typealias PieChartSliceValue = Positive<Double>
///
/// let value: PieChartSliceValue? = 263.333
/// ```
public struct Positive<Wrapped>: MaybeWrapping where Wrapped: Positivable {

    /// The underlying positive value.
    public let wrapped: Wrapped

    /// Creates an instance by wrapping the given value, or throws if the value is not positive.
    public init(_ value: Wrapped) throws(Error) {
        guard value.isPositive else { throw Error(value) }
        self.wrapped = value
    }

}


extension Positive {

    /// An error thrown when a positive value is rejected.
    public struct Error: Swift.Error, CustomStringConvertible {

        /// The value that failed validation.
        public let value: Wrapped

        /// A description of the error.
        public var description: String {
            "Value '\(value)' must be positive"
        }

        /// Creates an error for the given rejected value.
        internal init(_ value: Wrapped) {
            self.value = value
        }

    }

}


extension Positive: MaybeExpressible, AnyExpressible where Wrapped: Expressible {}

extension Positive: Codable where Wrapped: Codable {}
extension Positive: Comparable where Wrapped: Comparable {}
extension Positive: Equatable where Wrapped: Equatable {}
extension Positive: Hashable where Wrapped: Hashable {}
extension Positive: Sendable where Wrapped: Sendable {}

extension Positive.Error: Sendable where Wrapped: Sendable {}
