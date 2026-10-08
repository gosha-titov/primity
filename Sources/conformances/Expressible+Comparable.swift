// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

extension AnyExpressible where Expressed: Comparable {

    @_transparent
    public static func < <T>(lhs: Self, rhs: T) -> Bool where T: AnyExpressible, T.Expressed == Expressed {
        return lhs.expressed() < rhs.expressed()
    }

}
