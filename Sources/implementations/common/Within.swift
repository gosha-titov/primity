// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that ensures a value falls within a closed range.
///
/// Returns `nil` if the value is outside the bounds during initialization.
///
/// ## Example 1
/// ```
/// typealias OneThroughFive<Wrapped: Withinable> = Within<`1`, `5`, Wrapped> where Wrapped.Bound == Int
///
/// typealias Numbers = OneThroughFive<Array<Int>>
///
/// let numbers: Numbers? = [2, 1, 4, 3]
/// ```
///
/// ## Example 2
/// ```
/// typealias Child<Wrapped: Withinable> = Within<`0`, `18`, Wrapped> where Wrapped.Bound == Int
///
/// if let child = Child(user) {
///     pediatricHospital.makeApointment(for: child)
/// }
/// ```
public struct Within<LowerBound: Bound, UpperBound: Bound, Wrapped: Withinable>: MaybeWrapping where LowerBound.Value == UpperBound.Value, LowerBound.Value == Wrapped.Bound {

    /// The underlying value, guaranteed to be within the specified range.
    public let wrapped: Wrapped

    /// Creates an instance by wrapping the given value, or returns `nil` if it is out of bounds.
    public init(_ value: Wrapped) throws(Error) {
        let range = LowerBound.value...UpperBound.value
        guard value.isWithin(range) else { throw Error(value) }
        self.wrapped = value
    }

}


extension Within {

    /// An error thrown when a negative value is rejected.
    public struct Error: Swift.Error, CustomStringConvertible {

        /// The value that failed validation.
        public let value: Wrapped

        /// A description of the error.
        public var description: String {
            "Value '\(value)' must be within bounds \(LowerBound.value...UpperBound.value)"
        }

        /// Creates an error for the given rejected value.
        internal init(_ value: Wrapped) {
            self.value = value
        }

    }

}


extension Within: MaybeExpressible, AnyExpressible where Wrapped: Expressible {}

extension Within: Sequence where Wrapped: Sequence {}
extension Within: Collection where Wrapped: Collection {}
extension Within: BidirectionalCollection where Wrapped: BidirectionalCollection {}

extension Within: Codable where Wrapped: Codable {}
extension Within: Equatable where Wrapped: Equatable {}
extension Within: Hashable where Wrapped: Hashable {}
extension Within: Sendable where Wrapped: Sendable {}

extension Within.Error: Sendable where Wrapped: Sendable {}
