// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A type that can produce a truncated copy of itself, where excess characters are removed from the end.
public protocol Truncatable {

    /// The type used for range boundaries.
    associatedtype Bound

    /// Returns a copy truncated to the given length.
    ///
    /// ## Example
    /// ```
    /// let string = "Hello, world! Hello, world! Hello, world!"
    /// string.truncated(to: 32) // "Hello, world! Hello, world! Hell"
    /// ```
    func truncated(to length: Bound) -> Self

}


extension Wrapping where Wrapped: Truncatable {

    @inline(__always)
    public func truncated(to length: Wrapped.Bound) -> Self {
        return Self(wrapped.truncated(to: length))
    }

}


extension String: Truncatable {
    public func truncated(to length: Int) -> String {
        return String(prefix(length))
    }
}


extension Capitalized: Truncatable where Wrapped: Truncatable {}
extension Collapsed: Truncatable where Wrapped: Truncatable {}
extension Lowercased: Truncatable where Wrapped: Truncatable {}
extension Ragged: Truncatable where Wrapped: Truncatable {}
extension Stripped: Truncatable where Wrapped: Truncatable {}
extension Trimmed: Truncatable where Wrapped: Truncatable {}
extension Uppercased: Truncatable where Wrapped: Truncatable {}
