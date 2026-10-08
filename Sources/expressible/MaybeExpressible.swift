// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A type that validates a raw value and refuses to construct when the value doesn't satisfy its requirements.
///
/// Use this protocol for constrained types where the raw value might not satisfy the requirements.
///
/// ## Example
/// ```
/// typealias Name = NonEmpty<Trimmed<String>>
///
/// if let name = try? Name(expressing: "Mia") {...}
/// //                 NonEmpty(Trimmed("Mia"))
/// ```
public protocol MaybeExpressible: AnyExpressible {

    /// Creates an instance from the given raw value, or throws when the value is invalid.
    init(expressing value: Expressed) throws

}


extension MaybeExpressible {

    /// Creates an instance from the given raw value, or throws when the value is invalid.
    @inline(__always)
    public static func expressing(_ value: Expressed) throws -> Self {
        return try Self(expressing: value)
    }

    /// Creates an instance from the given raw value, or returns `nil` when the value is invalid.
    @inline(__always)
    public init?(expressing value: Expressed) {
        let make: (Expressed) throws -> Self = Self.init
        guard let value = try? make(value) else { return nil }
        self = value
    }

}
