// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

extension Array where Element: Equatable {

    /// Removes the specified element from the array.
    @inline(__always)
    internal mutating func remove(_ oldElement: Element) {
        removeAll { $0 == oldElement }
    }

    /// Removes the specified elements from the array.
    @inline(__always)
    internal mutating func remove<S: Sequence>(contentsOf oldElements: S) where S.Element == Element {
        removeAll(where: oldElements.contains)
    }

}
