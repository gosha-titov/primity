// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that capitalizes its value on creation.
///
/// ## Example
/// ```
/// typealias Title = Capitalized<String>
///
/// let title: Title = "swift best practices"
/// print(title) //    "Swift Best Practices"
/// ```
public struct Capitalized<Wrapped>: Wrapping where Wrapped: Capitalizable {

    /// The underlying capitalized textual value.
    public let wrapped: Wrapped

    /// Creates an instance by capitalizing the given value.
    public init(_ value: Wrapped) {
        self.wrapped = value.capitalized()
    }

}


extension Capitalized: Expressible, AnyExpressible where Wrapped: Expressible {}

extension Capitalized: Sequence where Wrapped: Sequence {}
extension Capitalized: Collection where Wrapped: Collection {}
extension Capitalized: BidirectionalCollection where Wrapped: BidirectionalCollection {}

extension Capitalized: Codable where Wrapped: Codable {}
extension Capitalized: Equatable where Wrapped: Equatable {}
extension Capitalized: Hashable where Wrapped: Hashable {}
extension Capitalized: Sendable where Wrapped: Sendable {}

extension Capitalized: ArrayExpressible, ExpressibleByArrayLiteral where Wrapped: ArrayExpressible {}
extension Capitalized: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Wrapped: ExpressibleByStringLiteral {}
