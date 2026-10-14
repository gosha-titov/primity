// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that keeps only the last elements or characters of its value on creation.
///
/// ## Example
/// ```
/// typealias UndoStack = Last<`50`, Array<Edit>>
///
/// // at most 50 edits — the newest ones
/// ```
public struct Last<Count: Constant, Wrapped: Cuttable>: Wrapping where Count.Value == Wrapped.Bound {

    /// The underlying value with only the last elements or characters kept.
    public let wrapped: Wrapped

    /// Creates an instance by keeping only the last elements or characters of the given value.
    public init(_ value: Wrapped) {
        self.wrapped = value.last(Count.value)
    }

}


extension Last: Expressible, AnyExpressible where Wrapped: Expressible {}

extension Last: Codable where Wrapped: Codable {}
extension Last: Equatable where Wrapped: Equatable {}
extension Last: Hashable where Wrapped: Hashable {}
extension Last: Sendable where Wrapped: Sendable {}

extension Last: Sequence where Wrapped: Sequence {}
extension Last: Collection where Wrapped: Collection {}
extension Last: BidirectionalCollection where Wrapped: BidirectionalCollection {}

extension Last: ArrayExpressible, ExpressibleByArrayLiteral where Wrapped: ArrayExpressible {}
extension Last: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Wrapped: ExpressibleByStringLiteral {}
