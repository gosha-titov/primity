// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct UniqueTests {

    @Test internal func method() {
        #expect([3, 1, 4, 1, 2, 3].deduped() == [3, 1, 4, 2])
        #expect([1, 1, 1].deduped() == [1])
        #expect([Int]().deduped() == [])
        #expect(["b", "a", "b"].deduped() == ["b", "a"])
    }

    @Test internal func validator() {
        #expect(Unique<[Int]>([1, 2, 3]) != nil)
        #expect(Unique<[Int]>([]) != nil)
        #expect(Unique<[Int]>([3, 1, 3]) == nil)
        #expect(Unique<[String]>(["a", "b", "a"]) == nil)
        #expect(throws: Unique<[Int]>.Error.self) {
            try Unique<[Int]>([3, 1, 3])
        }
    }

    @Test internal func adjuster() {
        #expect(Deduped<[Int]>([3, 1, 4, 1, 2, 3]) == [3, 1, 4, 2])
        #expect(Deduped<[String]>(["a", "b", "a"]) == ["a", "b"])
        #expect(Deduped<[Int]>([]) == [])
        #expect(Deduped<[Int]>([1, 2, 3]) == [1, 2, 3])
    }

    @Test internal func identifiers() {
        typealias Identifiers = Unique<Ascended<[Int]>>
        var ids: Identifiers! = [3, 1, 2]
        #expect(ids == [1, 2, 3])
        ids = [3, 1, 3]
        #expect(ids == nil)
    }

    @Test internal func tags() {
        typealias Tags = NonEmpty<Deduped<[String]>>
        var tags: Tags! = ["swift", "ios", "swift"]
        #expect(tags == ["swift", "ios"])
        tags = []
        #expect(tags == nil)
    }

    @Test internal func expressing() {
        #expect(Deduped<[Int]>(expressing: [3, 1, 3]) == [3, 1])
        #expect(Deduped<[Int]>.expressing([3, 1, 3]) == [3, 1])
        #expect(Deduped<[Int]>([3, 1, 3]).expressed() == [3, 1])
    }

    @Test internal func codable() throws {
        let original = Deduped<[Int]>([3, 1, 4, 1])
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == "[3,1,4]")
        let decoded = try JSONDecoder().decode(Deduped<[Int]>.self, from: encoded)
        #expect(decoded == original)
        let deduped = try JSONDecoder().decode(
            Deduped<[Int]>.self,
            from: try #require("[3,1,4,1]".data(using: .utf8))
        )
        #expect(deduped == Deduped<[Int]>([3, 1, 4]))
    }

    @Test internal func codableValidator() throws {
        let encoded = try #require("[3,1,3]".data(using: .utf8))
        #expect(throws: Unique<[Int]>.Error.self) {
            try JSONDecoder().decode(Unique<[Int]>.self, from: encoded)
        }
    }

    @Test internal func error() {
        let error = Unique<[Int]>.Error([3, 1, 3])
        #expect(error.value == [3, 1, 3])
        #expect(error.description == "Value '[3, 1, 3]' must contain unique elements")
    }

}
