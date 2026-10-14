// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that removes duplicate elements from a collection on creation.
///
/// Duplicates are removed during initialization, keeping the first
/// occurrence of each element and preserving the original order.
///
/// ## Example
/// ```
/// typealias Tags = Deduped<Array<String>>
///
/// let tags: Tags = ["swift", "ios", "swift"]
/// print(tags) // ["swift", "ios"]
/// ```
public struct Deduped<Wrapped: Dedupable>: Wrapping {

    /// The underlying collection value without duplicates.
    public let wrapped: Wrapped

    /// Creates an instance by removing duplicates from the given collection.
    public init(_ value: Wrapped) {
        self.wrapped = value.deduped()
    }

}


extension Deduped: Expressible, AnyExpressible where Wrapped: Expressible {}

extension Deduped: Equatable where Wrapped: Equatable {}
extension Deduped: Hashable where Wrapped: Hashable {}
extension Deduped: Codable where Wrapped: Codable {}
extension Deduped: Sendable where Wrapped: Sendable {}

extension Deduped: Sequence where Wrapped: Sequence {}
extension Deduped: Collection where Wrapped: Collection {}
extension Deduped: BidirectionalCollection where Wrapped: BidirectionalCollection {}
