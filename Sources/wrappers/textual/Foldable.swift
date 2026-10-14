// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation

/// A type that can produce a folded version of itself, suitable for case- and diacritic-insensitive comparison.
public protocol Foldable {

    /// Returns a copy folded for search: case and diacritics are removed.
    ///
    /// A folded value is a lookup key, not display text.
    ///
    /// ## Example
    /// ```
    /// "Émile".folded()  // "emile"
    /// "Straße".folded() // "strasse"
    /// ```
    func folded() -> Self

}


extension Wrapping where Wrapped: Foldable {

    /// Returns a copy with the wrapped value folded.
    @inline(__always)
    public func folded() -> Self {
        return Self(wrapped.folded())
    }

}


extension String: Foldable {

    public func folded() -> String {
        return folding(options: [.caseInsensitive, .diacriticInsensitive], locale: nil)
    }

}


extension Collapsed: Foldable where Wrapped: Foldable {}
extension Ragged: Foldable where Wrapped: Foldable {}
extension Stripped: Foldable where Wrapped: Foldable {}
extension Trimmed: Foldable where Wrapped: Foldable {}
extension First: Foldable where Wrapped: Foldable {}
extension Last: Foldable where Wrapped: Foldable {}
