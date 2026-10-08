// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct NonEmptyTests {

    @Test internal func string() throws {
        #expect(NonEmpty("") == nil)
        #expect(NonEmpty("a") != nil)
        #expect((try NonEmpty("hello")).wrapped == "hello")
        #expect(NonEmpty<String>(nil) == nil)
        #expect((try NonEmpty<String>(expressing: "hello")).wrapped == "hello")
        #expect(NonEmpty<String>(expressing: nil) == nil)
        #expect(NonEmpty<String>(expressing: "") == nil)
        #expect(NonEmpty<String>.single("1") == "1")
        #expect(throws: NonEmpty<String>.Error.self) {
            try NonEmpty("")
        }
        #expect(throws: NonEmpty<String>.Error.self) {
            try NonEmpty<String>(expressing: "")
        }
    }

    @Test internal func array() throws {
        #expect(NonEmpty<[Int]>([]) == nil)
        #expect(NonEmpty([1]) != nil)
        #expect((try NonEmpty([1, 2, 3])).wrapped == [1, 2, 3])
        #expect(NonEmpty<[Int]>(nil) == nil)
        #expect((try NonEmpty<[Int]>(expressing: [1, 2, 3])).wrapped == [1, 2, 3])
        #expect(NonEmpty<[Int]>(expressing: nil) == nil)
        #expect(NonEmpty<[Int]>(expressing: []) == nil)
        #expect(NonEmpty<[Int]>.single(1) == [1])
        #expect(throws: NonEmpty<[Int]>.Error.self) {
            try NonEmpty<[Int]>([])
        }
        #expect(throws: NonEmpty<[Int]>.Error.self) {
            try NonEmpty<[Int]>(expressing: [])
        }
    }

    @Test internal func set() throws {
        #expect(NonEmpty<Set<Int>>([]) == nil)
        #expect(NonEmpty(Set([1])) != nil)
        #expect((try NonEmpty(Set([1, 2, 3]))).wrapped == [1, 2, 3])
        #expect(NonEmpty<Set<Int>>(nil) == nil)
        #expect((try NonEmpty<Set<Int>>(expressing: [1, 2, 3])).wrapped == [1, 2, 3])
        #expect(NonEmpty<Set<Int>>(expressing: nil) == nil)
        #expect(NonEmpty<Set<Int>>(expressing: []) == nil)
        #expect(NonEmpty<Set<Int>>.single(1) == [1])
        #expect(throws: NonEmpty<Set<Int>>.Error.self) {
            try NonEmpty<Set<Int>>([])
        }
        #expect(throws: NonEmpty<Set<Int>>.Error.self) {
            try NonEmpty<Set<Int>>(expressing: [])
        }
    }

    @Test internal func dictionary() throws {
        #expect(NonEmpty([Int: String]()) == nil)
        #expect(NonEmpty([1: "one"]) != nil)
        #expect((try NonEmpty([1: "one", 2: "two"])).wrapped == [1: "one", 2: "two"])
        #expect(NonEmpty<[Int: String]>(nil) == nil)
        #expect((try NonEmpty<[Int: String]>(expressing: [1: "one", 2: "two"])).wrapped == [1: "one", 2: "two"])
        #expect(NonEmpty<[Int: String]>(expressing: nil) == nil)
        #expect(NonEmpty<[Int: String]>(expressing: [:]) == nil)
        #expect(NonEmpty<[Int: String]>.single("one", for: 1) == [1: "one"])
        #expect(throws: NonEmpty<[Int: String]>.Error.self) {
            _ = try NonEmpty<[Int: String]>([:])
        }
        #expect(throws: NonEmpty<[Int: String]>.Error.self) {
            try NonEmpty<[Int: String]>(expressing: [:])
        }
    }

    @Test internal func accessors() throws {
        let numbers = try NonEmpty([3, 1, 2])
        #expect(numbers.first == 3)
        #expect(numbers.last == 2)
        #expect(numbers.min() == 1)
        #expect(numbers.max() == 3)
        #expect(numbers.wrapped.contains(numbers.random()))
    }

    @Test internal func codable() throws {
        let original = try NonEmpty([1: "one", 2: "two"])
        let encoded = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(NonEmpty<[Int: String]>.self, from: encoded)
        #expect(decoded == original)
        let string = try #require(#""""#.data(using: .utf8))
        #expect(throws: NonEmpty<String>.Error.self) {
            try JSONDecoder().decode(NonEmpty<String>.self, from: string)
        }
        let array = try #require(#"[]"#.data(using: .utf8))
        #expect(throws: NonEmpty<[Int]>.Error.self) {
            try JSONDecoder().decode(NonEmpty<[Int]>.self, from: array)
        }
    }

}
