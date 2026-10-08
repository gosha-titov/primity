// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

extension Character {

    /// A boolean value indicating whether every Unicode scalar of the character is whitespace.
    @inline(__always)
    internal var isWhitespaceOnly: Bool {
        return unicodeScalars.allSatisfy(\.properties.isWhitespace)
    }

    /// A boolean value indicating whether the character is an emoji.
    @inline(__always)
    internal var isEmoji: Bool {
        return isSimpleEmoji || isCombinedIntoEmoji
    }

    /// A boolean value indicating whether the character is a simple, single-scalar emoji.
    @inline(__always)
    internal var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return (firstScalar.properties.isEmoji && firstScalar.value > 0x238C) || firstScalar.isEmoji
    }

    /// A boolean value indicating whether the character is a combined emoji sequence.
    @inline(__always)
    internal var isCombinedIntoEmoji: Bool {
        return unicodeScalars.count > 1 && (unicodeScalars.first?.properties.isEmoji ?? false)
    }

}
