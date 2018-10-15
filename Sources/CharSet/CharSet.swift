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
        let l = L.reduce(into: SetOfCharacter(), { (result, set) in
            result.formUnion(set)
        })
        let m = M.reduce(into: SetOfCharacter(), { (result, set) in
            result.formUnion(set)
        })
        let n = N.reduce(into: SetOfCharacter(), { (result, set) in
            result.formUnion(set)
        })
        
        return CharSet(l.union(m).union(n))
    }()
    
    public static let capitalizedLetters: CharSet = {
        return CharSet(Lt)
    }()
    
    public static let controlCharacters: CharSet = {
        return CharSet(Cc.union(Cf))
    }()
    
    public static let decimalDigits: CharSet = {
        return CharSet(Nd)
    }()
    
    public static let letters: CharSet = {
        let l = L.reduce(into: SetOfCharacter(), { (result, set) in
            result.formUnion(set)
        })
        let m = M.reduce(into: SetOfCharacter(), { (result, set) in
            result.formUnion(set)
        })
        
        return CharSet(l.union(m))
    }()
    
    public static let lowercaseLetters: CharSet = {
        return CharSet(Ll)
    }()
    
    public static let newlines: CharSet = {
        let content: [UInt32] = [0x000A, 0x000B, 0x000C, 0x000D, 0x0085, 0x2028, 0x2029]
        return CharSet(fromScalarArray(content))
    }()
    
    public static let nonBaseCharacters: CharSet = {
        let m = M.reduce(into: SetOfCharacter(), { (result, set) in
            result.formUnion(set)
        })
        return CharSet(m)
    }()
    
    public static let punctuationCharacters: CharSet = {
        let p = P.reduce(into: SetOfCharacter(), { (result, set) in
            result.formUnion(set)
        })
        return CharSet(p)
    }()
    
    public static let symbols: CharSet = {
        let s = S.reduce(into: SetOfCharacter(), { (result, set) in
            result.formUnion(set)
        })
        return CharSet(s)
    }()
    
    public static let uppercaseLetters: CharSet = {
        return CharSet(Lu.union(Lt))
    }()
    
    public static let whitespaces: CharSet = {
        let z = Z.reduce(into: SetOfCharacter(), { (result, set) in
            result.formUnion(set)
        })
        let tab = fromScalarArray([0x0009])
        return CharSet(z.union(tab))
    }()
    
    public static let whitespacesAndNewlines: CharSet = {
        let z = Z.reduce(into: SetOfCharacter(), { (result, set) in
            result.formUnion(set)
        })
        let tab = fromScalarArray([0x000A, 0x000B, 0x000C, 0x000D, 0x0085])
        return CharSet(z.union(tab))
    }()
    
    private static func fromScalarArray(_ list: [UInt32]) -> SetOfCharacter {
        return SetOfCharacter(list.lazy.compactMap(UnicodeScalar.init).map(Character.init))
    }
    
    private static let Lu: SetOfCharacter = fromScalarArray(UnicodeCategory.L.u())
    private static let Ll: SetOfCharacter = fromScalarArray(UnicodeCategory.L.l())
    private static let Lt: SetOfCharacter = fromScalarArray(UnicodeCategory.L.t())
    private static let Lm: SetOfCharacter = fromScalarArray(UnicodeCategory.L.m())
    private static let Lo: SetOfCharacter = fromScalarArray(UnicodeCategory.L.o())
    private static var L: [SetOfCharacter] { return [Lu, Ll, Lt, Lm, Lo] }
    
    private static let Mn: SetOfCharacter = fromScalarArray(UnicodeCategory.M.n())
    private static let Mc: SetOfCharacter = fromScalarArray(UnicodeCategory.M.c())
    private static let Me: SetOfCharacter = fromScalarArray(UnicodeCategory.M.e())
    private static var M: [SetOfCharacter] { return [Mn, Mc, Me] }
    
    private static let Nd: SetOfCharacter = fromScalarArray(UnicodeCategory.N.d())
    private static let Nl: SetOfCharacter = fromScalarArray(UnicodeCategory.N.l())
    private static let No: SetOfCharacter = fromScalarArray(UnicodeCategory.N.o())
    private static var N: [SetOfCharacter] { return [Nd, Nl, No] }
    
    private static let Pc: SetOfCharacter = fromScalarArray(UnicodeCategory.P.c())
    private static let Pd: SetOfCharacter = fromScalarArray(UnicodeCategory.P.d())
    private static let Ps: SetOfCharacter = fromScalarArray(UnicodeCategory.P.s())
    private static let Pe: SetOfCharacter = fromScalarArray(UnicodeCategory.P.e())
    private static let Pi: SetOfCharacter = fromScalarArray(UnicodeCategory.P.i())
    private static let Pf: SetOfCharacter = fromScalarArray(UnicodeCategory.P.f())
    private static let Po: SetOfCharacter = fromScalarArray(UnicodeCategory.P.o())
    private static var P: [SetOfCharacter] { return [Pc, Pd, Ps, Pe, Pi, Pf, Po] }
    
    private static let Sm: SetOfCharacter = fromScalarArray(UnicodeCategory.S.m())
    private static let Sc: SetOfCharacter = fromScalarArray(UnicodeCategory.S.c())
    private static let Sk: SetOfCharacter = fromScalarArray(UnicodeCategory.S.k())
    private static let So: SetOfCharacter = fromScalarArray(UnicodeCategory.S.o())
    private static var S: [SetOfCharacter] { return [Sm, Sc, Sk, So] }
    
    private static let Zs: SetOfCharacter = fromScalarArray(UnicodeCategory.Z.s())
    private static let Zl: SetOfCharacter = fromScalarArray(UnicodeCategory.Z.l())
    private static let Zp: SetOfCharacter = fromScalarArray(UnicodeCategory.Z.p())
    private static var Z: [SetOfCharacter] { return [Zs, Zl, Zp] }
    
    private static let Cc: SetOfCharacter = fromScalarArray(UnicodeCategory.C.c())
    private static let Cf: SetOfCharacter = fromScalarArray(UnicodeCategory.C.f())
    private static let Cs: SetOfCharacter = fromScalarArray(UnicodeCategory.C.s())
    private static let Co: SetOfCharacter = fromScalarArray(UnicodeCategory.C.o())
    private static var C: [SetOfCharacter] { return [Cc, Cf, Cs, Co] }
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

public func ?!=(lhs: Character, rhs: CharSet) -> Bool {
    return !(lhs ?= rhs)
}
