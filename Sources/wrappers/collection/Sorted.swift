// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that sorts a collection on creation
///
/// The collection is sorted using the specified strategy during initialization.
///
/// ## Example
/// ```
/// typealias Strategy = AscendingSortingStrategy<Int>
/// typealias Numbers = Sorted<Strategy, Array<Int>>
///
/// let numbers: Numbers = [3, 1, 4, 2]
/// print(numbers) // [1, 2, 3, 4]
/// ```
public struct Sorted<Strategy: SortingStrategy, Wrapped: Sortable>: Wrapping where Wrapped.Element == Strategy.Element {

    /// The underlying sorted collection value.
    public let wrapped: Wrapped

    /// Creates an instance by sorting the given collection.
    public init(_ value: Wrapped) {
        self.wrapped = value.sorted(by: Strategy.areInIncreasingOrder)
    }

}


/// A wrapper that sorts a collection in ascending order on creation
///
/// ## Example
/// ```
/// typealias Numbers = Ascended<Array<Int>>
///
/// let numbers: Numbers = [2, 4, 1, 5, 3]
/// print(numbers) // [1, 2, 3, 4, 5]
/// ```
public typealias Ascended<Value: Sortable> = Sorted<AscendingSortingStrategy<Value.Element>, Value> where Value.Element: Comparable

/// A wrapper that sorts a collection in descending order on creation
///
/// ## Example
/// ```
/// typealias Numbers = Descended<Array<Int>>
///
/// let numbers: Numbers = [2, 4, 1, 5, 3]
/// print(numbers) // [5, 4, 3, 2, 1]
/// ```
public typealias Descended<Value: Sortable> = Sorted<DescendingSortingStrategy<Value.Element>, Value> where Value.Element: Comparable


extension Sorted: Expressible, AnyExpressible where Wrapped: Expressible {}

extension Sorted: Equatable where Wrapped: Equatable {}
extension Sorted: Hashable where Wrapped: Hashable {}
extension Sorted: Codable where Wrapped: Codable {}
extension Sorted: Sendable where Wrapped: Sendable {}

extension Sorted: Sequence where Wrapped: Sequence {}
extension Sorted: Collection where Wrapped: Collection {}
extension Sorted: BidirectionalCollection where Wrapped: BidirectionalCollection {}
