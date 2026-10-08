// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A type that accepts any raw value.
///
/// Nested wrappers can be created concisely without manually writing every layer.
///
/// ## Example
/// ```
/// typealias Name = Trimmed<Stripped<String>>
///
/// let name = Name(expressing: "Mia")
/// //         Trimmed(Stripped("Mia"))
///
/// let string = name.expressed() // "Mia"
/// ```
public protocol Expressible: AnyExpressible {

    /// Creates an instance from the given raw value.
    init(expressing value: Expressed)

}


extension Expressible {

    /// Creates an instance from the given raw value.
    @_transparent
    public static func expressing(_ value: Expressed) -> Self {
        return Self(expressing: value)
    }

}


extension Expressible where Expressed == Self {

    /// Creates an instance from the given value.
    @_transparent
    public init(expressing value: Self) {
        self = value
    }

}
