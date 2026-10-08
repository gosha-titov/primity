// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

extension AnyWrapping where Self: AnyExpressible, Expressed == Int {

    /// Unwraps the innermost integer value.
    @inline(__always)
    public func asInt() -> Int {
        return expressed()
    }

}
