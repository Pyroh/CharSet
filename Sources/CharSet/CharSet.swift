//
//  CharSet.swift
//  CharSet
//
//  Copyright (c) Pierre Tacchi. All rights reserved.
//  Licensed under the MIT License. See LICENSE file in the project root for full license information.
//

import Foundation

infix operator ?=: ComparisonPrecedence
infix operator ?!=: ComparisonPrecedence



public struct CharSet {
    private typealias SetOfCharacter = Set<Character>
    
    private var storage: SetOfCharacter
    private var isReversed: Bool
    
    public var count: Int {
        return storage.count
    }
    
    public init() {
        self.storage = []
        self.isReversed = false
    }
    
    private init(_ set: SetOfCharacter) {
        self.storage = set
        self.isReversed = false
    }
    
    public func contains(_ char: Character) -> Bool {
        return self.storage.contains(char) != self.isReversed
    }
    
    public mutating func reverse() {
        self.isReversed.toggle()
    }
    
    public func reversed() -> CharSet {
        var cs = self
        cs.isReversed.toggle()
        return cs
    }
    
    public static let alphanumerics: CharSet = {
        return L + M + N
    }()
    
    public static let capitalizedLetters: CharSet = {
        return Lt
    }()
    
    public static let controlCharacters: CharSet = {
        return Cc + Cf
    }()
    
    public static let decimalDigits: CharSet = {
        return Nd
    }()
    
    public static let letters: CharSet = {
        return L + M
    }()
    
    public static let lowercaseLetters: CharSet = {
        return Ll
    }()
    
    public static let newlines: CharSet = {
        return CharSet(["\u{000A}", "\u{000B}", "\u{000C}", "\u{000D}", "\u{0085}", "\u{2028}", "\u{2029}"])
    }()
    
    public static let nonBaseCharacters: CharSet = {
        return M
    }()
    
    public static let punctuationCharacters: CharSet = {
        return P
    }()
    
    public static let symbols: CharSet = {
        return S
    }()
    
    public static let uppercaseLetters: CharSet = {
        return Lu + Lt
    }()
    
    public static let whitespaces: CharSet = {
        return Z + CharSet("\u{0009}")
    }()
    
    public static let whitespacesAndNewlines: CharSet = {
        return Z + CharSet(["\u{000A}", "\u{000B}", "\u{000C}", "\u{000D}", "\u{0085}"])
    }()
    
    private static func fromScalarArray(_ list: [UInt32]) -> SetOfCharacter {
        return SetOfCharacter(list.lazy.compactMap(UnicodeScalar.init).map(Character.init))
    }
    
    private static let Lu: CharSet = UnicodeCategory.L.u()
    private static let Ll: CharSet = UnicodeCategory.L.l()
    private static let Lt: CharSet = UnicodeCategory.L.t()
    private static let Lm: CharSet = UnicodeCategory.L.m()
    private static let Lo: CharSet = UnicodeCategory.L.o()
    private static var L:  CharSet { return Lu + Ll + Lt + Lm + Lo }
    
    private static let Mn: CharSet = UnicodeCategory.M.n()
    private static let Mc: CharSet = UnicodeCategory.M.c()
    private static let Me: CharSet = UnicodeCategory.M.e()
    private static var M:  CharSet { return Mn + Mc + Me }
    
    private static let Nd: CharSet = UnicodeCategory.N.d()
    private static let Nl: CharSet = UnicodeCategory.N.l()
    private static let No: CharSet = UnicodeCategory.N.o()
    private static var N:  CharSet { return Nd + Nl + No }
    
    private static let Pc: CharSet = UnicodeCategory.P.c()
    private static let Pd: CharSet = UnicodeCategory.P.d()
    private static let Ps: CharSet = UnicodeCategory.P.s()
    private static let Pe: CharSet = UnicodeCategory.P.e()
    private static let Pi: CharSet = UnicodeCategory.P.i()
    private static let Pf: CharSet = UnicodeCategory.P.f()
    private static let Po: CharSet = UnicodeCategory.P.o()
    private static var P:  CharSet { return Pc + Pd + Ps + Pe + Pi + Pf + Po }
    
    private static let Sm: CharSet = UnicodeCategory.S.m()
    private static let Sc: CharSet = UnicodeCategory.S.c()
    private static let Sk: CharSet = UnicodeCategory.S.k()
    private static let So: CharSet = UnicodeCategory.S.o()
    private static var S:  CharSet { return Sm + Sc + Sk + So }
    
    private static let Zs: CharSet = UnicodeCategory.Z.s()
    private static let Zl: CharSet = UnicodeCategory.Z.l()
    private static let Zp: CharSet = UnicodeCategory.Z.p()
    private static var Z:  CharSet { return Zs + Zl + Zp }
    
    private static let Cc: CharSet = UnicodeCategory.C.c()
    private static let Cf: CharSet = UnicodeCategory.C.f()
//    private static let Cs: CharSet = UnicodeCategory.C.s()
    private static let Co: CharSet = UnicodeCategory.C.o()
    private static var C:  CharSet { return Cc + Cf + Co }
}

extension CharSet: SetAlgebra {
    public func union(_ other: CharSet) -> CharSet {
        return CharSet(self.storage.union(other.storage))
    }
    
    public func intersection(_ other: CharSet) -> CharSet {
        return CharSet(self.storage.intersection(other.storage))
    }
    
    public func symmetricDifference(_ other: CharSet) -> CharSet {
        return CharSet(self.storage.symmetricDifference(other.storage))
    }
    
    public mutating func insert(_ newMember: Character) -> (inserted: Bool, memberAfterInsert: Character) {
        return self.storage.insert(newMember)
    }
    
    public mutating func remove(_ member: Character) -> Character? {
        return self.storage.remove(member)
    }
    
    public mutating func update(with newMember: Character) -> Character? {
        return self.storage.update(with: newMember)
    }
    
    public mutating func formUnion(_ other: CharSet) {
        self = self.union(other)
    }
    
    public mutating func formIntersection(_ other: CharSet) {
        self = self.intersection(other)
    }
    
    public mutating func formSymmetricDifference(_ other: CharSet) {
        self = self.symmetricDifference(other)
    }
    
}

extension CharSet: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    
    public init(stringLiteral str: StringLiteralType) {
        self.storage = Set(str)
        self.isReversed = false
    }
}

public func ~=(lhs: CharSet, rhs: Character) -> Bool {
    return lhs.contains(rhs)
}

public func ?=(lhs: Character, rhs: CharSet) -> Bool {
    return rhs.contains(lhs)
}

public func ?=(lhs: Character, rhs: [CharSet]) -> Bool {
    return rhs.lazy.map { lhs ?= $0 }.reduce(into: false, { $0 = $0 || $1 })
}

public func ?!=(lhs: Character, rhs: CharSet) -> Bool {
    return !(lhs ?= rhs)
}

public func ?!=(lhs: Character, rhs: [CharSet]) -> Bool {
    return !(lhs ?= rhs)
}

public func +(lhs: CharSet, rhs: CharSet) -> CharSet {
    return lhs.union(rhs)
}
