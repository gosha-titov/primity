// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A type that can return a version of itself with duplicate elements removed.
public protocol Dedupable {

    /// The type of elements in the collection.
    associatedtype Element: Hashable

    /// Returns a copy with duplicate elements removed, keeping the first occurrence of each.
    ///
    /// ## Example
    /// ```
    /// let array = [3, 1, 4, 1, 2, 3]
    /// array.deduped() // [3, 1, 4, 2]
    /// ```
    func deduped() -> Self

}


extension Array: Dedupable where Element: Hashable {

    public func deduped() -> Self {
        var seen = Set<Element>()
        return filter { element in seen.insert(element).inserted }
    }

}
