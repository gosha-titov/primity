// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A type that can produce a lowercase version of itself, where all letters are uppercased.
public protocol Uppercaseable {

    /// Returns a copy with all letters uppercased.
    ///
    /// ## Example
    /// ```
    /// let string = "Hello, World!"
    /// string.uppercased() // "HELLO, WORLD!"
    /// ```
    func uppercased() -> Self

}


extension Wrapping where Wrapped: Uppercaseable {

    @inline(__always)
    public func uppercased() -> Self {
        return Self(wrapped.uppercased())
    }

}


extension String: Uppercaseable {}

extension Collapsed: Uppercaseable where Wrapped: Uppercaseable {}
extension Ragged: Uppercaseable where Wrapped: Uppercaseable {}
extension Stripped: Uppercaseable where Wrapped: Uppercaseable {}
extension Trimmed: Uppercaseable where Wrapped: Uppercaseable {}
extension Truncated: Uppercaseable where Wrapped: Uppercaseable {}
