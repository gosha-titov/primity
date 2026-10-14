// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that ensures a value matches an exact bound.
///
/// ## Example 1
/// ```
/// typealias RGB = Exact<`3`, Array<UInt8>>
///
/// let color: RGB? = [255, 168, 0]
/// ```
///
/// ## Example 2
/// ```
/// typealias Row<Cols, Value> = Exact<Cols, Array<Value>>
///     where Cols: Constant, Cols.Value == Int
/// typealias Grid<Cols, Rows, Value> = Exact<Rows, Array<Row<Cols, Value>>>
///     where Cols: Constant, Rows: Constant, Cols.Value == Int, Rows.Value == Int
///
/// if let board = Grid<`3`, `3`, Mark>(rows) {
///     tictactoe.play(on: board)
/// }
/// ```
public struct Exact<Count: Constant, Wrapped: Withinable>: MaybeWrapping where Count.Value == Wrapped.Bound {

    /// The underlying value, guaranteed to match the exact bound.
    public let wrapped: Wrapped

    /// Creates an instance by wrapping the given value, or throws if it doesn't match the bound exactly.
    public init(_ value: Wrapped) throws(Error) {
        let bound = Count.value
        guard value.isWithin(bound...bound) else { throw Error(value) }
        self.wrapped = value
    }

}


extension Exact {

    /// An error thrown when a mismatched value is rejected.
    public struct Error: Swift.Error, CustomStringConvertible {

        /// The value that failed validation.
        public let value: Wrapped

        /// A description of the error.
        public var description: String {
            "Value '\(value)' must be exactly \(Count.value)"
        }

        /// Creates an error for the given rejected value.
        internal init(_ value: Wrapped) {
            self.value = value
        }

    }

}


extension Exact: MaybeExpressible, AnyExpressible where Wrapped: Expressible {}

extension Exact: Sequence where Wrapped: Sequence {}
extension Exact: Collection where Wrapped: Collection {}
extension Exact: BidirectionalCollection where Wrapped: BidirectionalCollection {}

extension Exact: Codable where Wrapped: Codable {}
extension Exact: Equatable where Wrapped: Equatable {}
extension Exact: Hashable where Wrapped: Hashable {}
extension Exact: Sendable where Wrapped: Sendable {}

extension Exact.Error: Sendable where Wrapped: Sendable {}
