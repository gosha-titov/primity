// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

private struct ByLength: SortingStrategy {
    static func areInIncreasingOrder(lhs: String, rhs: String) -> Bool {
        return lhs.count < rhs.count
    }
}

internal struct SortedTests {

    @Test internal func method() {
        #expect(AscendingSortingStrategy<Int>.areInIncreasingOrder(lhs: 1, rhs: 2))
        #expect(!AscendingSortingStrategy<Int>.areInIncreasingOrder(lhs: 2, rhs: 1))
        #expect(DescendingSortingStrategy<Int>.areInIncreasingOrder(lhs: 2, rhs: 1))
        #expect(!DescendingSortingStrategy<Int>.areInIncreasingOrder(lhs: 1, rhs: 2))
        #expect([3, 1, 2].sorted(by: AscendingSortingStrategy<Int>.areInIncreasingOrder) == [1, 2, 3])
        #expect([3, 1, 2].sorted(by: DescendingSortingStrategy<Int>.areInIncreasingOrder) == [3, 2, 1])
    }

    @Test internal func wrapper() {
        #expect(Sorted<AscendingSortingStrategy<Int>, [Int]>([3, 1, 4, 2]) == [1, 2, 3, 4])
        #expect(Sorted<DescendingSortingStrategy<Int>, [Int]>([3, 1, 4, 2]) == [4, 3, 2, 1])
        #expect(Sorted<AscendingSortingStrategy<Int>, [Int]>([]) == [])
        #expect(Ascended([2, 4, 1, 5, 3]) == [1, 2, 3, 4, 5])
        #expect(Descended([2, 4, 1, 5, 3]) == [5, 4, 3, 2, 1])
        #expect(Sorted<ByLength, [String]>(["ccc", "a", "bb"]) == ["a", "bb", "ccc"])
    }

    @Test internal func expressing() {
        #expect(Sorted<AscendingSortingStrategy<Int>, [Int]>(expressing: [3, 1, 2]) == [1, 2, 3])
        #expect(Sorted<AscendingSortingStrategy<Int>, [Int]>.expressing([3, 1, 2]) == [1, 2, 3])
        #expect(Sorted<AscendingSortingStrategy<Int>, [Int]>([3, 1, 2]).expressed() == [1, 2, 3])
    }

    @Test internal func codable() throws {
        let original = Sorted<AscendingSortingStrategy<Int>, [Int]>([3, 1, 2])
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == "[1,2,3]")
        let decoded = try JSONDecoder().decode(Sorted<AscendingSortingStrategy<Int>, [Int]>.self, from: encoded)
        #expect(decoded == original)
        let sorted = try JSONDecoder().decode(
            Sorted<AscendingSortingStrategy<Int>, [Int]>.self,
            from: try #require("[3,1,2]".data(using: .utf8))
        )
        #expect(sorted == Sorted<AscendingSortingStrategy<Int>, [Int]>([1, 2, 3]))
    }

}
