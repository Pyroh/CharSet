//
//  UnicodeCategoryZ.swift
//  CharSet
//
//  Copyright (c) Pierre Tacchi. All rights reserved.
//  Licensed under the MIT License. See LICENSE file in the project root for full license information.
//

extension UnicodeCategory {
    struct Z {
        static func s() -> [UInt32] {
            return [0x0020, 0x00A0, 0x1680, 0x2000, 0x2001, 0x2002, 0x2003, 0x2004, 0x2005, 0x2006, 0x2007, 0x2008, 0x2009, 0x200A, 0x202F, 0x205F, 0x3000]
        }
        
        static func l() -> [UInt32] {
            return [0x2028]
        }
        
        static func p() -> [UInt32] {
            return [0x2029]
        }
    }
}
