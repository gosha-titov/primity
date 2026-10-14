// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation

/// A type that can produce a collapsed version of itself, where consecutive whitespace is replaced with a single space.
public protocol Collapsible {

    /// Returns a copy with consecutive whitespace characters replaced by a single space.
    ///
    /// ## Example
    /// ```
    /// let string = "Hello, \n  world!"
    /// string.collapsed() // "Hello, world!"
    /// ```
    func collapsed() -> Self

}


extension Wrapping where Wrapped: Collapsible {

    @inline(__always)
    public func collapsed() -> Self {
        return Self(wrapped.collapsed())
    }

}


extension String: Collapsible {

    public func collapsed() -> String {
        let maybeRegex = try? NSRegularExpression(pattern: "\\s+", options: .caseInsensitive)
        guard let regex = maybeRegex else { return self }
        let range = NSRange(startIndex..., in: self)
        return regex.stringByReplacingMatches(in: self, options: .empty, range: range, withTemplate: .space)
    }

}


extension Capitalized: Collapsible where Wrapped: Collapsible {}
extension Lowercased: Collapsible where Wrapped: Collapsible {}
extension Ragged: Collapsible where Wrapped: Collapsible {}
extension Stripped: Collapsible where Wrapped: Collapsible {}
extension Trimmed: Collapsible where Wrapped: Collapsible {}
extension First: Collapsible where Wrapped: Collapsible {}
extension Last: Collapsible where Wrapped: Collapsible {}
extension Uppercased: Collapsible where Wrapped: Collapsible {}
