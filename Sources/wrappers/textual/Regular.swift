// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A wrapper that ensures a string matches a regular expression pattern entirely.
///
/// ## Example
/// ```
/// enum EmailPattern: Constant {
///     static let value = /[^@\s]+@[^@\s]+\.[^@\s]+/
/// }
///
/// typealias Email = Regular<EmailPattern, String>
///
/// let email: Email? = "gosha@example.com"
/// ```
@available(macOS 13, iOS 16, macCatalyst 16, tvOS 16, watchOS 9, *)
public struct Regular<Pattern: Constant, Wrapped: StringProtocol>: MaybeWrapping where Pattern.Value: RegexComponent, Wrapped.SubSequence == Substring {

    /// The underlying string, guaranteed to match the pattern entirely.
    public let wrapped: Wrapped

    /// Creates an instance by wrapping the given string, or throws if it doesn't match the pattern entirely.
    public init(_ value: Wrapped) throws(Error) {
        guard value.wholeMatch(of: Pattern.value) != nil else { throw Error(value) }
        self.wrapped = value
    }

}


@available(macOS 13, iOS 16, macCatalyst 16, tvOS 16, watchOS 9, *)
extension Regular {

    /// An error thrown when a string not matching the pattern is rejected.
    public struct Error: Swift.Error, CustomStringConvertible {

        /// The value that failed validation.
        public let value: Wrapped

        /// A description of the error.
        public var description: String {
            "Value '\(value)' must match the pattern '\(Pattern.value)'"
        }

        /// Creates an error for the given rejected value.
        internal init(_ value: Wrapped) {
            self.value = value
        }

    }

}


@available(macOS 13, iOS 16, macCatalyst 16, tvOS 16, watchOS 9, *)
extension Regular: MaybeExpressible, AnyExpressible where Wrapped: Expressible {}

@available(macOS 13, iOS 16, macCatalyst 16, tvOS 16, watchOS 9, *)
extension Regular: Codable where Wrapped: Codable {}
@available(macOS 13, iOS 16, macCatalyst 16, tvOS 16, watchOS 9, *)
extension Regular: Equatable where Wrapped: Equatable {}
@available(macOS 13, iOS 16, macCatalyst 16, tvOS 16, watchOS 9, *)
extension Regular: Hashable where Wrapped: Hashable {}
@available(macOS 13, iOS 16, macCatalyst 16, tvOS 16, watchOS 9, *)
extension Regular: Sendable where Wrapped: Sendable {}

@available(macOS 13, iOS 16, macCatalyst 16, tvOS 16, watchOS 9, *)
extension Regular.Error: Sendable where Wrapped: Sendable {}


// A compiled regex is immutable after creation and safe to match with from any thread.
@available(macOS 13, iOS 16, macCatalyst 16, tvOS 16, watchOS 9, *)
extension Regex: @unchecked @retroactive Sendable {}
