// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import Foundation
@testable import Primity
import Testing

internal struct ExactTests {

    @Test internal func int() throws {
        #expect(Exact<`3`, Int>(2) == nil)
        #expect(Exact<`3`, Int>(4) == nil)
        #expect(Exact<`3`, Int>(3) != nil)
        #expect((try Exact<`3`, Int>(3)).wrapped == 3)
        #expect((try Exact<`3`, Int>(expressing: 3)).wrapped == 3)
        let value: Exact<`3`, Int>? = 3
        #expect(value?.wrapped == 3)
        let invalid: Exact<`3`, Int>? = 4
        #expect(invalid == nil)
        #expect(throws: Exact<`3`, Int>.Error.self) {
            try Exact<`3`, Int>(4)
        }
    }

    @Test internal func string() throws {
        #expect(Exact<`5`, String>("hey") == nil)
        #expect(Exact<`5`, String>("hello!") == nil)
        #expect((try Exact<`5`, String>("hello")).wrapped == "hello")
        let value: Exact<`5`, String>? = "hello"
        #expect(value?.wrapped == "hello")
        let invalid: Exact<`5`, String>? = "hey"
        #expect(invalid == nil)
    }

    @Test internal func collection() throws {
        #expect(Row<`3`, Int>([1, 2]) == nil)
        #expect(Row<`3`, Int>([1, 2, 3, 4]) == nil)
        #expect((try Row<`3`, Int>([1, 2, 3])).wrapped == [1, 2, 3])
        let value: Row<`3`, Int>? = [1, 2, 3]
        #expect(value?.wrapped == [1, 2, 3])
        let invalid: Row<`3`, Int>? = [1, 2]
        #expect(invalid == nil)
    }

    @Test internal func codable() throws {
        let original = try Row<`3`, Int>([1, 2, 3])
        let encoded = try JSONEncoder().encode(original)
        #expect(String(data: encoded, encoding: .utf8) == "[1,2,3]")
        let decoded = try JSONDecoder().decode(Row<`3`, Int>.self, from: encoded)
        #expect(decoded == original)
        let mismatched = try #require("[1,2]".data(using: .utf8))
        #expect(throws: Row<`3`, Int>.Error.self) {
            try JSONDecoder().decode(Row<`3`, Int>.self, from: mismatched)
        }
    }

    @Test internal func error() {
        let error = Exact<`3`, [Int]>.Error([1, 2])
        #expect(error.value == [1, 2])
        #expect(error.description == "Value '[1, 2]' must be exactly 3")
    }

    @Test internal func grid() throws {
        let firstRow = try Row<`3`, Int>([1, 2, 3])
        let secondRow = try Row<`3`, Int>([4, 5, 6])
        #expect(Grid<`3`, `2`, Int>([firstRow, secondRow]) != nil)
        #expect(Grid<`3`, `2`, Int>([firstRow]) == nil)
        #expect(Grid<`3`, `2`, Int>([]) == nil)
        let grid = try Grid<`3`, `2`, Int>([firstRow, secondRow])
        #expect(grid.wrapped.map(\.wrapped) == [[1, 2, 3], [4, 5, 6]])
    }

}


extension ExactTests {
    private typealias Row<Cols, Value> = Exact<Cols, Array<Value>>
        where Cols: Constant, Cols.Value == Int
    private typealias Grid<Cols, Rows, Value> = Exact<Rows, Array<Row<Cols, Value>>>
        where Cols: Constant, Rows: Constant, Cols.Value == Int, Rows.Value == Int
}
