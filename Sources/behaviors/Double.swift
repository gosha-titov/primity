// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

extension AnyWrapping where Self: AnyExpressible, Expressed == Double {

    /// Unwraps the innermost `Double` value.
    @inline(__always)
    public func asDouble() -> Double {
        return expressed()
    }

}
