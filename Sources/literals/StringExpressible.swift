// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

extension Wrapping where Wrapped: ExpressibleByStringLiteral {

    public init(stringLiteral value: Wrapped.StringLiteralType) {
        self.init(Wrapped(stringLiteral: value))
    }

}


extension Optional: @retroactive
    ExpressibleByStringLiteral,
    ExpressibleByExtendedGraphemeClusterLiteral,
    ExpressibleByUnicodeScalarLiteral
where Wrapped: MaybeExpressible, Wrapped.Expressed: ExpressibleByStringLiteral {

    public init(stringLiteral value: Wrapped.Expressed.StringLiteralType) {
        self = Wrapped(expressing: Wrapped.Expressed(stringLiteral: value))
    }

}
