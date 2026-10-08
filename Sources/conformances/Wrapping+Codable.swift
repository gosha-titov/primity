// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

extension Wrapping where Wrapped: Codable {

    @_transparent
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrapped)
    }

    @_transparent
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(try container.decode(Wrapped.self))
    }

}


extension MaybeWrapping where Wrapped: Codable {

    @_transparent
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrapped)
    }

    @_transparent
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        try self.init(try container.decode(Wrapped.self))
    }

}
