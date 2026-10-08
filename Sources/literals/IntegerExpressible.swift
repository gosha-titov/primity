// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

extension Wrapping where Wrapped: ExpressibleByIntegerLiteral {

    public init(integerLiteral value: Wrapped.IntegerLiteralType) {
        self.init(Wrapped(integerLiteral: value))
    }

}


extension Optional: @retroactive ExpressibleByIntegerLiteral where Wrapped: MaybeExpressible, Wrapped.Expressed: ExpressibleByIntegerLiteral {

    public init(integerLiteral value: Wrapped.Expressed.IntegerLiteralType) {
        self = Wrapped(expressing: Wrapped.Expressed(integerLiteral: value))
    }

}
