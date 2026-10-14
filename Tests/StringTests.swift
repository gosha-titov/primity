// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct StringTests {

    @Test internal func asString() throws {
        #expect(Trimmed<String>(" hello ").asString() == "hello")

        let nonEmpty = try NonEmpty("hello")
        #expect(nonEmpty.asString() == "hello")
    }

    @Test internal func empty() {
        #expect(Trimmed<String>.empty.wrapped.isEmpty)
        #expect(Collapsed<String>.empty.asString().isEmpty)
    }

    @Test internal func appending() throws {
        let trimmed = Trimmed<String>("hello")
        #expect(trimmed.appending("!") == "hello!")
        #expect(trimmed.appending(" ") == "hello")
        #expect(trimmed.appending(contentsOf: " world ") == "hello world")

        let stripped = Stripped<String>("hello")
        #expect(stripped.appending("👋") == "hello")

        let nonEmpty = try NonEmpty("hello")
        #expect(try nonEmpty.appending("!") == "hello!")
        #expect(try nonEmpty.appending(contentsOf: " world") == "hello world")
        #expect(nonEmpty.appending("!")?.wrapped == "hello!")
        #expect(nonEmpty.appending(contentsOf: " world")?.wrapped == "hello world")
    }

    @Test internal func prepending() throws {
        let trimmed = Trimmed<String>("hello")
        #expect(trimmed.prepending("!") == "!hello")
        #expect(trimmed.prepending(" ") == "hello")
        #expect(trimmed.prepending(contentsOf: "say ") == "say hello")

        let nonEmpty = try NonEmpty("hello")
        #expect(try nonEmpty.prepending("!") == "!hello")
        #expect(try nonEmpty.prepending(contentsOf: "say ") == "say hello")
        #expect(nonEmpty.prepending("!")?.wrapped == "!hello")
        #expect(nonEmpty.prepending(contentsOf: "say ")?.wrapped == "say hello")
    }

    @Test internal func inserting() throws {
        let trimmed = Trimmed<String>("hello")
        let index = trimmed.wrapped.index(trimmed.wrapped.startIndex, offsetBy: 1)
        #expect(trimmed.inserting("!", at: index) == "h!ello")
        #expect(trimmed.inserting(contentsOf: "--", at: index) == "h--ello")

        let nonEmpty = try NonEmpty("hello")
        let nonEmptyIndex = nonEmpty.wrapped.index(nonEmpty.wrapped.startIndex, offsetBy: 1)
        #expect(try nonEmpty.inserting("!", at: nonEmptyIndex) == "h!ello")
        #expect(try nonEmpty.inserting(contentsOf: "--", at: nonEmptyIndex) == "h--ello")
        #expect(nonEmpty.inserting("!", at: nonEmptyIndex)?.wrapped == "h!ello")
        #expect(nonEmpty.inserting(contentsOf: "--", at: nonEmptyIndex)?.wrapped == "h--ello")
    }

    @Test internal func removing() throws {
        let trimmed = Trimmed<String>("hello")
        let index = trimmed.wrapped.index(trimmed.wrapped.startIndex, offsetBy: 1)
        #expect(trimmed.removing(at: index) == "hllo")

        let nonEmpty = try NonEmpty("hello")
        let nonEmptyIndex = nonEmpty.wrapped.index(nonEmpty.wrapped.startIndex, offsetBy: 1)
        #expect(try nonEmpty.removing(at: nonEmptyIndex) == "hllo")
        #expect(nonEmpty.removing(at: nonEmptyIndex)?.wrapped == "hllo")

        let single = try NonEmpty("a")
        #expect(single.removing(at: single.wrapped.startIndex) == nil)
        #expect(throws: NonEmpty<String>.Error.self) {
            try single.removing(at: single.wrapped.startIndex)
        }
    }

    @Test internal func revalidation() throws {
        let value = try Within<`1`, `5`, String>("abc")
        #expect(try value.appending("d") == "abcd")
        #expect(value.appending(contentsOf: "def") == nil)
        #expect(throws: Within<`1`, `5`, String>.Error.self) {
            try value.appending(contentsOf: "def")
        }

        let single = try Within<`1`, `5`, String>("a")
        #expect(single.removing(at: single.wrapped.startIndex) == nil)
    }

}
