// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A type that can be cut down to its first or last elements or characters.
public protocol Cuttable {

    /// The type used for the count.
    associatedtype Bound

    /// Returns a copy with only the first elements or characters kept.
    ///
    /// ## Example
    /// ```
    /// "hello world".first(5) // "hello"
    /// ```
    func first(_ count: Bound) -> Self

    /// Returns a copy with only the last elements or characters kept.
    ///
    /// ## Example
    /// ```
    /// "hello world".last(5) // "world"
    /// ```
    func last(_ count: Bound) -> Self

}


extension Wrapping where Wrapped: Cuttable {

    @inline(__always)
    public func first(_ count: Wrapped.Bound) -> Self {
        return Self(wrapped.first(count))
    }

    @inline(__always)
    public func last(_ count: Wrapped.Bound) -> Self {
        return Self(wrapped.last(count))
    }

}


extension Array: Cuttable {
    public func first(_ count: Int) -> Array {
        return Array(prefix(count))
    }
    public func last(_ count: Int) -> Array {
        return Array(suffix(count))
    }
}

extension String: Cuttable {
    public func first(_ count: Int) -> String {
        return String(prefix(count))
    }
    public func last(_ count: Int) -> String {
        return String(suffix(count))
    }
}


extension Capitalized: Cuttable where Wrapped: Cuttable {}
extension Collapsed: Cuttable where Wrapped: Cuttable {}
extension Lowercased: Cuttable where Wrapped: Cuttable {}
extension Ragged: Cuttable where Wrapped: Cuttable {}
extension Stripped: Cuttable where Wrapped: Cuttable {}
extension Trimmed: Cuttable where Wrapped: Cuttable {}
extension Uppercased: Cuttable where Wrapped: Cuttable {}
