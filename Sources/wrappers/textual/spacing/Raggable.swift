// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

/// A type that can produce a ragged version of itself, where trailing whitespace is removed from each line.
public protocol Raggable {

    /// Returns a copy with trailing whitespace removed from each line.
    ///
    /// ## Example (underscores represent spaces)
    /// ```
    /// let string = """
    /// __Hello___
    /// _world!__
    /// """
    ///
    /// string.ragged()
    /// // """
    /// // __Hello
    /// // _world!
    /// // """
    /// ```
    func ragged() -> Self

}


extension Wrapping where Wrapped: Raggable {

    @inline(__always)
    public func ragged() -> Self {
        return Self(wrapped.ragged())
    }

}


extension String: Raggable {

    public func ragged() -> String {
        var result = String()
        result.reserveCapacity(utf8.count)
        var trailingWhitespace = String()
        for character in self {
            if character.isNewline {
                trailingWhitespace.removeAll(keepingCapacity: true)
                result.append(character)
            } else if character.isWhitespaceOnly {
                trailingWhitespace.append(character)
            } else {
                result.append(trailingWhitespace)
                trailingWhitespace.removeAll(keepingCapacity: true)
                result.append(character)
            }
        }
        return result
    }

}


extension Capitalized: Raggable where Wrapped: Raggable {}
extension Collapsed: Raggable where Wrapped: Raggable {}
extension Lowercased: Raggable where Wrapped: Raggable {}
extension Stripped: Raggable where Wrapped: Raggable {}
extension Trimmed: Raggable where Wrapped: Raggable {}
extension First: Raggable where Wrapped: Raggable {}
extension Last: Raggable where Wrapped: Raggable {}
extension Uppercased: Raggable where Wrapped: Raggable {}
