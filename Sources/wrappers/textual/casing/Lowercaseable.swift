// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A type that can produce a lowercase version of itself, where all letters are lowercased.
public protocol Lowercaseable {

    /// Returns a copy with all letters lowercased.
    ///
    /// ## Example
    /// ```
    /// let string = "Hello, World!"
    /// string.lowercased() // "hello, world!"
    /// ```
    func lowercased() -> Self

}


extension Wrapping where Wrapped: Lowercaseable {

    @inline(__always)
    public func lowercased() -> Self {
        return Self(wrapped.lowercased())
    }

}


extension String: Lowercaseable {}

extension Collapsed: Lowercaseable where Wrapped: Lowercaseable {}
extension Ragged: Lowercaseable where Wrapped: Lowercaseable {}
extension Stripped: Lowercaseable where Wrapped: Lowercaseable {}
extension Trimmed: Lowercaseable where Wrapped: Lowercaseable {}
extension First: Lowercaseable where Wrapped: Lowercaseable {}
extension Last: Lowercaseable where Wrapped: Lowercaseable {}
