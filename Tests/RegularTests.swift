// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct RegularTests {

    @Test internal func email() {
        guard #available(macOS 13, *) else { return }
        #expect(Email("gosha@example.com") != nil)
        #expect(Email("mia.sub@example.co.uk") != nil)
        #expect(Email("not-an-email") == nil)
        // Whole-string match: a partial match is a rejection
        #expect(Email("write to gosha@example.com please") == nil)
        #expect(throws: Regular<EmailPattern, String>.Error.self) {
            try Regular<EmailPattern, String>("not-an-email")
        }
    }

    @Test internal func username() {
        guard #available(macOS 13, *) else { return }
        #expect(Username("gosha_256") != nil)
        #expect(Username("Gosha") == nil)
        #expect(Username("go sha") == nil)
    }

    @Test internal func codable() throws {
        guard #available(macOS 13, *) else { return }
        let original = try Email("gosha@example.com")
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == "\"gosha@example.com\"")
        let decoded = try JSONDecoder().decode(Email.self, from: encoded)
        #expect(decoded == original)
        let invalid = try #require("\"not-an-email\"".data(using: .utf8))
        #expect(throws: Regular<EmailPattern, String>.Error.self) {
            try JSONDecoder().decode(Email.self, from: invalid)
        }
    }

    @Test internal func error() {
        guard #available(macOS 13, *) else { return }
        let error = Regular<EmailPattern, String>.Error("not-an-email")
        #expect(error.value == "not-an-email")
        #expect(error.description == "Value 'not-an-email' must match the pattern '\(EmailPattern.value)'")
    }

}


@available(macOS 13, iOS 16, macCatalyst 16, tvOS 16, watchOS 9, *)
extension RegularTests {
    internal enum EmailPattern: Constant {
        internal static let value = /^[^@\s]+@[^@\s]+\.[^@\s]+$/
    }
    internal enum UsernamePattern: Constant {
        internal static let value = /^[a-z0-9_]+$/
    }
    internal typealias Email = Regular<EmailPattern, String>
    internal typealias Username = Regular<UsernamePattern, String>
}
