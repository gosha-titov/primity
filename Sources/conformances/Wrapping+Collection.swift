// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

extension AnyWrapping where Wrapped: Sequence {

    @_transparent
    public func makeIterator() -> Wrapped.Iterator {
        return wrapped.makeIterator()
    }

}


extension AnyWrapping where Wrapped: Collection {

    @_transparent
    public var startIndex: Wrapped.Index {
        return wrapped.startIndex
    }

    @_transparent
    public var endIndex: Wrapped.Index {
        return wrapped.endIndex
    }

    @_transparent
    public func index(after index: Wrapped.Index) -> Wrapped.Index {
        return wrapped.index(after: index)
    }

    @inline(__always)
    public subscript(index: Wrapped.Index) -> Wrapped.Element {
        return wrapped[index]
    }

}


extension AnyWrapping where Wrapped: BidirectionalCollection {

    @_transparent
    public func index(before index: Wrapped.Index) -> Wrapped.Index {
        return wrapped.index(before: index)
    }

}
