// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that folds its value on creation.
///
/// Case and diacritics are removed during initialization, making the value
/// suitable for case- and diacritic-insensitive comparison. A folded value
/// is a lookup key, not display text — use it for search and dictionaries,
/// never for showing to users.
///
/// Unlike `Lowercased`, folding also removes diacritics: "Émile" becomes "emile".
///
/// ## Example 1
/// ```
/// typealias Key = Folded<Collapsed<Trimmed<String>>>
///
/// let key: Key = "  Émile "
/// // "emile"
/// ```
///
/// ## Example 2
/// ```
/// typealias Key = Folded<Collapsed<Trimmed<String>>>
/// typealias Contacts = Dictionary<Key, Contact>
///
/// if let contact = contacts[Key(expressing: "emile")] {
///     // found, regardless of case and accents
/// }
/// ```
public struct Folded<Wrapped>: Wrapping where Wrapped: Foldable {

    /// The underlying folded textual value.
    public let wrapped: Wrapped

    /// Creates an instance by folding the given value.
    public init(_ value: Wrapped) {
        self.wrapped = value.folded()
    }

}


extension Folded: Expressible, AnyExpressible where Wrapped: Expressible {}

extension Folded: Codable where Wrapped: Codable {}
extension Folded: Equatable where Wrapped: Equatable {}
extension Folded: Hashable where Wrapped: Hashable {}
extension Folded: Sendable where Wrapped: Sendable {}

extension Folded: Sequence where Wrapped: Sequence {}
extension Folded: Collection where Wrapped: Collection {}
extension Folded: BidirectionalCollection where Wrapped: BidirectionalCollection {}

extension Folded: ArrayExpressible, ExpressibleByArrayLiteral where Wrapped: ArrayExpressible {}
extension Folded: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Wrapped: ExpressibleByStringLiteral {}
