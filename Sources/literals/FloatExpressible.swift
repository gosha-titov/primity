// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

extension Wrapping where Wrapped: ExpressibleByFloatLiteral {

    public init(floatLiteral value: Wrapped.FloatLiteralType) {
        self.init(Wrapped(floatLiteral: value))
    }

}


extension Optional: @retroactive ExpressibleByFloatLiteral where Wrapped: MaybeExpressible, Wrapped.Expressed: ExpressibleByFloatLiteral {

    public init(floatLiteral value: Wrapped.Expressed.FloatLiteralType) {
        self = Wrapped(expressing: Wrapped.Expressed(floatLiteral: value))
    }

}
