// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

extension AnyWrapping where Wrapped: Comparable {

    @_transparent
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.wrapped < rhs.wrapped
    }

}


extension AnyWrapping where Wrapped: Expressible, Wrapped.Expressed: Comparable {

    @_transparent
    public static func < (lhs: Self, rhs: Wrapped.Expressed) -> Bool {
        return lhs.expressed() < rhs
    }

    @_transparent
    public static func < (lhs: Wrapped.Expressed, rhs: Self) -> Bool {
        return lhs < rhs.expressed()
    }

}
