// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

extension String {

    /// The string containing only the new-line symbol.
    @inline(__always)
    internal static var newline: String {
        return "\n"
    }

    /// The string containing only the space symbol.
    @inline(__always)
    internal static var space: String {
        return " "
    }
    
    /// The empty string.
    @inline(__always)
    internal static var empty: String {
        return ""
    }

}
