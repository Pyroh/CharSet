//
//  UnicodeCategoryZ.swift
//  CharSet
//
//  Copyright (c) Pierre Tacchi. All rights reserved.
//  Licensed under the MIT License. See LICENSE file in the project root for full license information.
//

extension UnicodeCategory {
    struct Z {
        static func s() -> CharSet {
            return CharSet(["\u{0020}", "\u{00A0}", "\u{1680}", "\u{2000}", "\u{2001}", "\u{2002}", "\u{2003}", "\u{2004}", "\u{2005}", "\u{2006}", "\u{2007}", "\u{2008}", "\u{2009}", "\u{200A}", "\u{202F}", "\u{205F}", "\u{3000}"])
        }
        
        static func l() -> CharSet {
            return CharSet(["\u{2028}"])
        }
        
        static func p() -> CharSet {
            return CharSet(["\u{2029}"])
        }
    }
}
