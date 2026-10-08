// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct DictionaryTests {

    @Test internal func asDictionary() throws {
        #expect(TestWrapper(["a": 1]).asDictionary() == ["a": 1])

        let nonEmpty = try NonEmpty(["a": 1, "b": 2])
        #expect(nonEmpty.asDictionary() == ["a": 1, "b": 2])
    }

    @Test internal func setting() throws {
        let dict = TestWrapper(["a": 1])
        #expect(dict.setting(2, for: "b") == ["a": 1, "b": 2])
        #expect(dict.setting(9, for: "a") == ["a": 9])

        let nonEmpty = try NonEmpty(["a": 1])
        #expect(try nonEmpty.setting(2, for: "b") == ["a": 1, "b": 2])
        #expect(try nonEmpty.setting(9, for: "a") == ["a": 9])
        #expect(nonEmpty.setting(2, for: "b")?.wrapped == ["a": 1, "b": 2])
        #expect(nonEmpty.setting(9, for: "a")?.wrapped == ["a": 9])
    }

    @Test internal func removing() throws {
        let dict = TestWrapper(["a": 1, "b": 2])
        #expect(dict.removing(for: "a") == ["b": 2])
        #expect(dict.removing(for: "z") == ["a": 1, "b": 2])
        #expect(dict.removing { $0.value > 1 } == ["a": 1])

        let nonEmpty = try NonEmpty(["a": 1, "b": 2])
        #expect(try nonEmpty.removing(for: "a") == ["b": 2])
        #expect(try nonEmpty.removing { $0.value > 1 } == ["a": 1])
        #expect(nonEmpty.removing(for: "a")?.wrapped == ["b": 2])
        #expect(nonEmpty.removing { $0.value > 1 }?.wrapped == ["a": 1])

        let single = try NonEmpty(["a": 1])
        #expect(single.removing(for: "a") == nil)
        #expect(throws: NonEmpty<[String: Int]>.Error.self) {
            try single.removing(for: "a")
        }
    }

    @Test internal func filtering() throws {
        let dict = TestWrapper(["a": 1, "b": 2])
        #expect(dict.filtering { $0.value > 1 } == ["b": 2])

        let nonEmpty = try NonEmpty(["a": 1, "b": 2])
        #expect(try nonEmpty.filtering { $0.value > 1 } == ["b": 2])
        #expect(nonEmpty.filtering { $0.value > 1 }?.wrapped == ["b": 2])
        #expect(nonEmpty.filtering { $0.value > 10 } == nil)
        #expect(throws: NonEmpty<[String: Int]>.Error.self) {
            try nonEmpty.filtering { $0.value > 10 }
        }
    }

    @Test internal func revalidation() throws {
        let pair = try Within<`1`, `3`, [String: Int]>(["a": 1, "b": 2])
        #expect(try pair.setting(3, for: "c") == ["a": 1, "b": 2, "c": 3])

        let triple = try Within<`1`, `3`, [String: Int]>(["a": 1, "b": 2, "c": 3])
        #expect(triple.setting(4, for: "d") == nil)
        #expect(throws: Within<`1`, `3`, [String: Int]>.Error.self) {
            try triple.setting(4, for: "d")
        }
    }

}


extension DictionaryTests {
    
    /// A minimal `Wrapping` wrapper over a dictionary, used to exercise the non-failable behavior paths.
    private struct TestWrapper: Wrapping, Expressible {

        let wrapped: [String: Int]

        init(_ value: [String: Int]) {
            self.wrapped = value
        }

    }
    
}
