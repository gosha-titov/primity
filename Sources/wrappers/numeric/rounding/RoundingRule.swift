// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation

/// A rule that determines how a value is rounded to a multiple of a step.
public enum RoundingRule: Sendable {
    
    /// Away from zero — the magnitude grows.
    case up

    /// Toward zero — the magnitude shrinks (truncation).
    case down

    /// To the nearest multiple, ties away from zero (schoolbook rounding).
    case nearest

}


extension RoundingRule {

    /// The equivalent floating-point rounding rule.
    public var floatingPointRule: FloatingPointRoundingRule {
        switch self {
        case .up: .awayFromZero
        case .down:  .towardZero
        case .nearest: .toNearestOrAwayFromZero
        }
    }

    /// The equivalent decimal rounding mode for a value with the given sign.
    public func decimalMode(isNegative: Bool) -> Decimal.RoundingMode {
        return switch self {
        case .up: isNegative ? .down : .up
        case .down: isNegative ? .up : .down
        case .nearest: .plain
        }
    }

}


extension RoundingRule {

    /// A rounding rule that rounds up, away from zero — the magnitude grows.
    public enum Up: Constant {
        public static let value = RoundingRule.up
    }

    /// A rounding rule that rounds down, toward zero — the magnitude shrinks (truncation).
    public enum Down: Constant {
        public static let value = RoundingRule.down
    }
    
    /// A rounding rule that rounds to the nearest multiple, ties away from zero (schoolbook rounding).
    public enum Nearest: Constant {
        public static let value = RoundingRule.nearest
    }
    
}
