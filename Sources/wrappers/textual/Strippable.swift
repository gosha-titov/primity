// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation

/// A type that can produce a stripped copy of itself, where decorative elements (like emojis) are removed.
public protocol Strippable {

    /// Returns a copy with decorative elements removed.
    ///
    /// ## Example
    /// ```
    /// let string = "Hello, 👋 World! 🌍 Let's meet at 3️⃣ PM."
    /// string.stripped() // "Hello,  World!  Let's meet at  PM."
    /// ```
    func stripped() -> Self

}


extension Wrapping where Wrapped: Strippable {

    @inline(__always)
    public func stripped() -> Self {
        return Self(wrapped.stripped())
    }

}


extension String: Strippable {

    public func stripped() -> String {
        var string = String()
        enumerateSubstrings(in: startIndex..<endIndex, options: .byComposedCharacterSequences) { substring, _, _, _ in
            if let substring, !substring.contains(where: \.isEmoji) {
                string.append(substring)
            }
        }
        return string
    }

}


extension Capitalized: Strippable where Wrapped: Strippable {}
extension Collapsed: Strippable where Wrapped: Strippable {}
extension Lowercased: Strippable where Wrapped: Strippable {}
extension Ragged: Strippable where Wrapped: Strippable {}
extension Trimmed: Strippable where Wrapped: Strippable {}
extension First: Strippable where Wrapped: Strippable {}
extension Last: Strippable where Wrapped: Strippable {}
extension Uppercased: Strippable where Wrapped: Strippable {}
