// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct ArrayTests {

    @Test internal func asArray() throws {
        let sorted = Sorted<AscendingSortingStrategy<Int>, [Int]>([3, 1, 2])
        #expect(sorted.asArray() == [1, 2, 3])

        let nonEmpty = try NonEmpty([3, 1, 2])
        #expect(nonEmpty.asArray() == [3, 1, 2])
    }

    @Test internal func appending() throws {
        let sorted = Sorted<AscendingSortingStrategy<Int>, [Int]>([3, 1, 2])
        #expect(sorted.appending(0) == [0, 1, 2, 3])
        #expect(sorted.appending(contentsOf: [5, 4]) == [1, 2, 3, 4, 5])

        let nonEmpty = try NonEmpty([1, 2, 3])
        #expect(try nonEmpty.appending(4) == [1, 2, 3, 4])
        #expect(try nonEmpty.appending(contentsOf: [4, 5]) == [1, 2, 3, 4, 5])
        #expect(nonEmpty.appending(4)?.wrapped == [1, 2, 3, 4])
        #expect(nonEmpty.appending(contentsOf: [4, 5])?.wrapped == [1, 2, 3, 4, 5])
    }

    @Test internal func prepending() throws {
        let sorted = Sorted<AscendingSortingStrategy<Int>, [Int]>([3, 1, 2])
        #expect(sorted.prepending(4) == [1, 2, 3, 4])
        #expect(sorted.prepending(contentsOf: [0, -1]) == [-1, 0, 1, 2, 3])

        let nonEmpty = try NonEmpty([1, 2, 3])
        #expect(try nonEmpty.prepending(0) == [0, 1, 2, 3])
        #expect(try nonEmpty.prepending(contentsOf: [-1, 0]) == [-1, 0, 1, 2, 3])
        #expect(nonEmpty.prepending(0)?.wrapped == [0, 1, 2, 3])
        #expect(nonEmpty.prepending(contentsOf: [-1, 0])?.wrapped == [-1, 0, 1, 2, 3])
    }

    @Test internal func inserting() throws {
        let sorted = Sorted<AscendingSortingStrategy<Int>, [Int]>([3, 1, 2])
        #expect(sorted.inserting(0, at: 0) == [0, 1, 2, 3])
        #expect(sorted.inserting(contentsOf: [5, 4], at: 3) == [1, 2, 3, 4, 5])

        let nonEmpty = try NonEmpty([1, 2, 3])
        #expect(try nonEmpty.inserting(0, at: 0) == [0, 1, 2, 3])
        #expect(try nonEmpty.inserting(contentsOf: [4, 5], at: 3) == [1, 2, 3, 4, 5])
        #expect(nonEmpty.inserting(0, at: 0)?.wrapped == [0, 1, 2, 3])
        #expect(nonEmpty.inserting(contentsOf: [4, 5], at: 3)?.wrapped == [1, 2, 3, 4, 5])
    }

    @Test internal func setting() throws {
        let sorted = Sorted<AscendingSortingStrategy<Int>, [Int]>([3, 1, 2])
        #expect(sorted.setting(9, at: 0) == [2, 3, 9])

        let nonEmpty = try NonEmpty([1, 2, 3])
        #expect(try nonEmpty.setting(9, at: 0) == [9, 2, 3])
        #expect(nonEmpty.setting(9, at: 0)?.wrapped == [9, 2, 3])
    }

    @Test internal func removing() throws {
        let sorted = Sorted<AscendingSortingStrategy<Int>, [Int]>([2, 1, 2, 3])
        #expect(sorted.removing(at: 0) == [2, 2, 3])
        #expect(sorted.removing(2) == [1, 3])
        #expect(sorted.removing(contentsOf: [1, 3]) == [2, 2])
        #expect(sorted.removing { $0 > 1 } == [1])

        let nonEmpty = try NonEmpty([1, 2, 3])
        #expect(try nonEmpty.removing(at: 0) == [2, 3])
        #expect(try nonEmpty.removing(1) == [2, 3])
        #expect(try nonEmpty.removing(contentsOf: [1, 2]) == [3])
        #expect(try nonEmpty.removing { $0 > 1 } == [1])
        #expect(nonEmpty.removing(at: 0)?.wrapped == [2, 3])
        #expect(nonEmpty.removing(1)?.wrapped == [2, 3])
        #expect(nonEmpty.removing(contentsOf: [1, 2])?.wrapped == [3])
        #expect(nonEmpty.removing { $0 > 1 }?.wrapped == [1])

        let single = try NonEmpty([1])
        #expect(single.removing(at: 0) == nil)
        #expect(single.removing(1) == nil)
        #expect(throws: NonEmpty<[Int]>.Error.self) {
            try single.removing(at: 0)
        }
        #expect(throws: NonEmpty<[Int]>.Error.self) {
            try single.removing(1)
        }
    }

    @Test internal func filtering() throws {
        let sorted = Sorted<AscendingSortingStrategy<Int>, [Int]>([3, 1, 2])
        #expect(sorted.filtering { $0 > 1 } == [2, 3])

        let nonEmpty = try NonEmpty([1, 2, 3])
        #expect(try nonEmpty.filtering { $0 > 1 } == [2, 3])
        #expect(nonEmpty.filtering { $0 > 1 }?.wrapped == [2, 3])
        #expect(nonEmpty.filtering { $0 > 10 } == nil)
        #expect(throws: NonEmpty<[Int]>.Error.self) {
            try nonEmpty.filtering { $0 > 10 }
        }
    }

}
