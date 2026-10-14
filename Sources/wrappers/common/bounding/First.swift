// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that keeps only the first elements or characters of its value on creation.
///
/// ## Example
/// ```
/// typealias Preview = First<`3`, Array<Item>>
///
/// let preview = Preview(allItems) // at most 3 items, from the start
/// ```
public struct First<Count: Constant, Wrapped: Cuttable>: Wrapping where Count.Value == Wrapped.Bound {

    /// The underlying value with only the first elements or characters kept.
    public let wrapped: Wrapped

    /// Creates an instance by keeping only the first elements or characters of the given value.
    public init(_ value: Wrapped) {
        self.wrapped = value.first(Count.value)
    }

}


extension First: Expressible, AnyExpressible where Wrapped: Expressible {}

extension First: Codable where Wrapped: Codable {}
extension First: Equatable where Wrapped: Equatable {}
extension First: Hashable where Wrapped: Hashable {}
extension First: Sendable where Wrapped: Sendable {}

extension First: Sequence where Wrapped: Sequence {}
extension First: Collection where Wrapped: Collection {}
extension First: BidirectionalCollection where Wrapped: BidirectionalCollection {}

extension First: ArrayExpressible, ExpressibleByArrayLiteral where Wrapped: ArrayExpressible {}
extension First: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Wrapped: ExpressibleByStringLiteral {}
