// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that validates its value and refuses to construct when the value doesn't satisfy its requirements.
public protocol MaybeWrapping: AnyWrapping {

    /// Creates an instance by wrapping the given value, or throws when the value is invalid.
    init(_ value: Wrapped) throws

}


extension MaybeWrapping {

    /// Creates an instance by wrapping the given value, or returns `nil` when the value is invalid.
    @inline(__always)
    public init?(_ value: Wrapped) {
        let make: (Wrapped) throws -> Self = Self.init
        guard let wrapper = try? make(value) else { return nil }
        self = wrapper
    }

}


extension MaybeWrapping where Wrapped: Expressible {

    /// Creates an instance by wrapping the given innermost raw value, or throws when the value is invalid.
    @inline(__always)
    public init(expressing value: Wrapped.Expressed) throws {
        try self.init(Wrapped(expressing: value))
    }

}
