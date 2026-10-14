// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A type that can indicate whether it is empty.
public protocol Emptyable {

    /// A boolean value indicating whether the instance is empty.
    var isEmpty: Bool { get }

}


extension Wrapping where Wrapped: Emptyable {

    @_transparent
    public var isEmpty: Bool {
        return wrapped.isEmpty
    }

}


extension Sorted: Emptyable where Wrapped: Emptyable {}
extension Unique: Emptyable where Wrapped: Emptyable {}
extension Deduped: Emptyable where Wrapped: Emptyable {}

extension Capitalized: Emptyable where Wrapped: Emptyable {}
extension Collapsed: Emptyable where Wrapped: Emptyable {}
extension Lowercased: Emptyable where Wrapped: Emptyable {}
extension Ragged: Emptyable where Wrapped: Emptyable {}
extension Stripped: Emptyable where Wrapped: Emptyable {}
extension Trimmed: Emptyable where Wrapped: Emptyable {}
extension First: Emptyable where Wrapped: Emptyable {}
extension Last: Emptyable where Wrapped: Emptyable {}
extension Uppercased: Emptyable where Wrapped: Emptyable {}

extension Array: Emptyable {}
extension Dictionary: Emptyable {}
extension Range: Emptyable {}
extension Set: Emptyable {}
extension String: Emptyable {}
