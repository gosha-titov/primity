// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A type that provides a single compile-time-known static value.
///
/// Typically implemented by empty enums that carry a constant used by
/// wrappers — as a bound, a rounding step, a count, a pattern.
///
/// ## Example
/// ```
/// enum `16`: Constant {
///     static let value = 16
/// }
/// ```
public protocol Constant {

    /// The type of the constant value.
    associatedtype Value

    /// The constant value.
    static var value: Value { get }

}


public enum `0`: Constant {
    public static let value = 0
}

public enum `0.0`: Constant {
    public static let value = 0.0
}

public enum `0.01`: Constant {
    public static let value = 0.01
}

public enum `0.1`: Constant {
    public static let value = 0.1
}

public enum `0.25`: Constant {
    public static let value = 0.25
}

public enum `0.5`: Constant {
    public static let value = 0.5
}

public enum `1`: Constant {
    public static let value = 1
}

public enum `1.0`: Constant {
    public static let value = 1.0
}

public enum `2`: Constant {
    public static let value = 2
}

public enum `3`: Constant {
    public static let value = 3
}

public enum `4`: Constant {
    public static let value = 4
}

public enum `5`: Constant {
    public static let value = 5
}

public enum `10`: Constant {
    public static let value = 10
}

public enum `100`: Constant {
    public static let value = 100
}
