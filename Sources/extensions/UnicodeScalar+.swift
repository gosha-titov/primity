// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT


extension UnicodeScalar {

    /// A boolean value indicating whether the scalar is a recognized emoji character.
    internal var isEmoji: Bool {
        switch self.value {
        case 0x1F600...0x1F64F,
             0x1F300...0x1F5FF,
             0x1F680...0x1F6FF,
             0x1F1E6...0x1F1FF,
             0xE0020...0xE007F,
             0xFE00...0xFE0F,
             0x1F900...0x1F9FF,
             0x1F018...0x1F0F5,
             0x1F200...0x1F270,
             65_024...65_039,
             9_100...9_300,
             8_400...8_447,
             0x1F004,
             0x1F18E,
             0x1F191...0x1F19A,
             0x1F5E8,
             0x1FA70...0x1FA73,
             0x1FA78...0x1FA7A,
             0x1FA80...0x1FA82,
             0x1FA90...0x1FA95,
             0x1FAE0,
             0x1FAF0...0x1FAF6,
             0x1F382:
            return true

        case 0x2603,
             0x265F,
             0x267E,
             0x2692,
             0x26C4,
             0x26C8,
             0x26CE,
             0x26CF,
             0x26D1...0x26D3,
             0x26E9,
             0x26F0...0x26F9,
             0x2705,
             0x270A,
             0x270B,
             0x2728,
             0x274E,
             0x2753...0x2755,
             0x274C,
             0x2795...0x2797,
             0x27B0,
             0x27BF:
            return true

        default:
            return false
        }
    }

}
