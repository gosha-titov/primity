// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct SetTests {

    @Test internal func asSet() throws {
        #expect(TestWrapper([3, 1, 2]).asSet() == [1, 2, 3])

        let nonEmpty = try NonEmpty(Set([3, 1, 2]))
        #expect(nonEmpty.asSet() == [1, 2, 3])
    }

    @Test internal func inserting() throws {
        let set = TestWrapper([1, 2, 3])
        #expect(set.inserting(4) == [1, 2, 3, 4])
        #expect(set.inserting(1) == [1, 2, 3])
        #expect(set.inserting(contentsOf: [4, 5, 1]) == [1, 2, 3, 4, 5])

        let nonEmpty = try NonEmpty(Set([1, 2, 3]))
        #expect(try nonEmpty.inserting(4) == [1, 2, 3, 4])
        #expect(try nonEmpty.inserting(contentsOf: [4, 5]) == [1, 2, 3, 4, 5])
        #expect(nonEmpty.inserting(4)?.wrapped == [1, 2, 3, 4])
        #expect(nonEmpty.inserting(contentsOf: [4, 5])?.wrapped == [1, 2, 3, 4, 5])
    }

    @Test internal func removing() throws {
        let set = TestWrapper([1, 2, 3])
        #expect(set.removing(1) == [2, 3])
        #expect(set.removing(10) == [1, 2, 3])
        #expect(set.removing(contentsOf: [1, 2]) == [3])
        #expect(set.removing { $0 > 1 } == [1])

        let nonEmpty = try NonEmpty(Set([1, 2, 3]))
        #expect(try nonEmpty.removing(1) == [2, 3])
        #expect(try nonEmpty.removing(contentsOf: [1, 2]) == [3])
        #expect(try nonEmpty.removing { $0 > 1 } == [1])
        #expect(nonEmpty.removing(1)?.wrapped == [2, 3])
        #expect(nonEmpty.removing(contentsOf: [1, 2])?.wrapped == [3])
        #expect(nonEmpty.removing { $0 > 1 }?.wrapped == [1])

        let single = try NonEmpty(Set([1]))
        #expect(single.removing(1) == nil)
        #expect(single.removing(contentsOf: [1]) == nil)
        #expect(throws: NonEmpty<Set<Int>>.Error.self) {
            try single.removing(1)
        }
        #expect(throws: NonEmpty<Set<Int>>.Error.self) {
            try single.removing(contentsOf: [1])
        }
    }

    @Test internal func filtering() throws {
        let set = TestWrapper([1, 2, 3])
        #expect(set.filtering { $0 > 1 } == [2, 3])

        let nonEmpty = try NonEmpty(Set([1, 2, 3]))
        #expect(try nonEmpty.filtering { $0 > 1 } == [2, 3])
        #expect(nonEmpty.filtering { $0 > 1 }?.wrapped == [2, 3])
        #expect(nonEmpty.filtering { $0 > 10 } == nil)
        #expect(throws: NonEmpty<Set<Int>>.Error.self) {
            try nonEmpty.filtering { $0 > 10 }
        }
    }

    @Test internal func revalidation() throws {
        let value = try Within<`1`, `3`, Set<Int>>([1, 2])
        #expect(try value.inserting(3) == [1, 2, 3])
        #expect(value.inserting(contentsOf: [3, 4]) == nil)
        #expect(throws: Within<`1`, `3`, Set<Int>>.Error.self) {
            try value.inserting(contentsOf: [3, 4])
        }
    }

}


extension SetTests {
    private struct TestWrapper: Wrapping, Expressible {
        let wrapped: Set<Int>
        init(_ value: Set<Int>) {
            self.wrapped = value
        }
    }
}
