// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct AtMostTests {

    @Test internal func int() throws {
        #expect(AtMost<`5`, Int>(6) == nil)
        #expect(AtMost<`5`, Int>(5) != nil)
        #expect(AtMost<`5`, Int>(-100) != nil)
        #expect((try AtMost<`5`, Int>(3)).wrapped == 3)
        #expect((try AtMost<`5`, Int>(expressing: 3)).wrapped == 3)
        let value: AtMost<`5`, Int>? = 3
        #expect(value?.wrapped == 3)
        let invalid: AtMost<`5`, Int>? = 6
        #expect(invalid == nil)
        #expect(throws: AtMost<`5`, Int>.Error.self) {
            try AtMost<`5`, Int>(6)
        }
    }

    @Test internal func string() throws {
        #expect(AtMost<`5`, String>("hello!") == nil)
        #expect(AtMost<`5`, String>("hello") != nil)
        #expect((try AtMost<`5`, String>("hey")).wrapped == "hey")
        let value: AtMost<`5`, String>? = "hey"
        #expect(value?.wrapped == "hey")
        let invalid: AtMost<`5`, String>? = "hello!"
        #expect(invalid == nil)
    }

    @Test internal func collection() throws {
        #expect(Attachments([1, 2, 3, 4, 5, 6]) == nil)
        #expect(Attachments([1, 2, 3, 4, 5]) != nil)
        #expect(Attachments([]) != nil)
        #expect((try Attachments([1, 2, 3])).wrapped == [1, 2, 3])
        let value: Attachments? = [1, 2, 3]
        #expect(value?.wrapped == [1, 2, 3])
        let invalid: Attachments? = [1, 2, 3, 4, 5, 6]
        #expect(invalid == nil)
    }

    @Test internal func double() throws {
        #expect(AtMost<`1.0`, Double>(1.5) == nil)
        #expect(AtMost<`1.0`, Double>(1.0) != nil)
        #expect((try AtMost<`1.0`, Double>(0.97)).wrapped == 0.97)
        let value: AtMost<`1.0`, Double>? = 0.97
        #expect(value?.wrapped == 0.97)
        let invalid: AtMost<`1.0`, Double>? = 1.5
        #expect(invalid == nil)
    }

    @Test internal func codable() throws {
        let original = try Attachments([1, 2, 3])
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == "[1,2,3]")
        let decoded = try JSONDecoder().decode(Attachments.self, from: encoded)
        #expect(decoded == original)
        let tooMany = try #require("[1,2,3,4,5,6]".data(using: .utf8))
        #expect(throws: Attachments.Error.self) {
            try JSONDecoder().decode(Attachments.self, from: tooMany)
        }
    }

    @Test internal func error() {
        let error = AtMost<`5`, [Int]>.Error([1, 2, 3, 4, 5, 6])
        #expect(error.value == [1, 2, 3, 4, 5, 6])
        #expect(error.description == "Value '[1, 2, 3, 4, 5, 6]' must be at most 5")
    }

}


extension AtMostTests {
    private typealias Attachments = AtMost<`5`, [Int]>
}
