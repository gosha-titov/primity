// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation

/// A type that can indicate whether it is finite — not `nan`, not infinite.
public protocol Finitable {

    /// A boolean value indicating whether the instance is finite.
    var isFinite: Bool { get }

}


extension Wrapping where Wrapped: Finitable {

    @_transparent
    public var isFinite: Bool {
        return wrapped.isFinite
    }

}


extension Clamped: Finitable where Wrapped: Finitable {}
extension Cycled: Finitable where Wrapped: Finitable {}
extension RoundedWith: Finitable where Wrapped: Finitable {}


extension Decimal: Finitable {

    public var isFinite: Bool {
        return !isNaN
    }

}

extension Double: Finitable {}
extension Float: Finitable {}
