// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that uppercases its value on creation.
///
/// ## Example
/// ```
/// typealias Abbreviation = Uppercased<String>
///
/// let text: Abbreviation = "url"
/// print(text) //           "URL"
/// ```
public struct Uppercased<Wrapped>: Wrapping where Wrapped: Uppercaseable {

    /// The underlying uppercased textual value.
    public let wrapped: Wrapped

    /// Creates an instance by uppercasing the given value.
    public init(_ value: Wrapped) {
        self.wrapped = value.uppercased()
    }

}


extension Uppercased: Expressible, AnyExpressible where Wrapped: Expressible {}

extension Uppercased: Codable where Wrapped: Codable {}
extension Uppercased: Equatable where Wrapped: Equatable {}
extension Uppercased: Hashable where Wrapped: Hashable {}
extension Uppercased: Sendable where Wrapped: Sendable {}

extension Uppercased: Sequence where Wrapped: Sequence {}
extension Uppercased: Collection where Wrapped: Collection {}
extension Uppercased: BidirectionalCollection where Wrapped: BidirectionalCollection {}

extension Uppercased: ArrayExpressible, ExpressibleByArrayLiteral where Wrapped: ArrayExpressible {}
extension Uppercased: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Wrapped: ExpressibleByStringLiteral {}
