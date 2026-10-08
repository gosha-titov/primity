// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A type that can be initialized with an array value.
public protocol ArrayExpressible: ExpressibleByArrayLiteral {

    /// The type of the elements of an array literal.
    associatedtype ArrayLiteralElement

    /// Creates an instance from the array.
    init(array: [ArrayLiteralElement])

}


extension Wrapping where Wrapped: ArrayExpressible {

    public init(arrayLiteral elements: Wrapped.ArrayLiteralElement...) {
        self.init(array: elements)
    }

    public init(array: [Wrapped.ArrayLiteralElement]) {
        self.init(Wrapped(array: array))
    }

}


extension Optional: @retroactive ExpressibleByArrayLiteral where Wrapped: MaybeExpressible, Wrapped.Expressed: ArrayExpressible {

    public init(arrayLiteral elements: Wrapped.Expressed.ArrayLiteralElement...) {
        self = Wrapped(expressing: Wrapped.Expressed(array: elements))
    }

}


extension Array: ArrayExpressible {

    public init(array: [Element]) {
        self = array
    }

}


extension Set: ArrayExpressible where ArrayLiteralElement: Hashable {

    public init(array: [Element]) {
        self = Set(array)
    }

}
