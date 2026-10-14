// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation

/// A type that can produce a capitalized version of itself, where the first letter of each word is uppercased.
public protocol Capitalizable {

    /// Returns a copy with the first character of each word uppercased.
    ///
    /// ## Example
    /// ```
    /// let string = "hello, world!"
    /// string.capitalized() // "Hello, World!"
    /// ```
    func capitalized() -> Self

}


extension Wrapping where Wrapped: Capitalizable {

    @inline(__always)
    public func capitalized() -> Self {
        return Self(wrapped.capitalized())
    }

}


extension String: Capitalizable {
    public func capitalized() -> String {
        return capitalized
    }
}


extension Collapsed: Capitalizable where Wrapped: Capitalizable {}
extension Ragged: Capitalizable where Wrapped: Capitalizable {}
extension Stripped: Capitalizable where Wrapped: Capitalizable {}
extension Trimmed: Capitalizable where Wrapped: Capitalizable {}
extension First: Capitalizable where Wrapped: Capitalizable {}
extension Last: Capitalizable where Wrapped: Capitalizable {}
