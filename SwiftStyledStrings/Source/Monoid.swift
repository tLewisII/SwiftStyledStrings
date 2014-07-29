//
//  Monoid.swift
//  AttributedStringBuilder
//
//  Created by Terry Lewis II on 7/28/14.
//  Copyright (c) 2014 Blue Plover Productions LLC. All rights reserved.
//

import Foundation

public protocol Monoid {
    typealias M
    func mempty() -> M
    func mappend(a:M) -> M
}

public operator infix <> {
associativity left
}

@infix public func <><A:Monoid where A.M == A>(lhs:A, rhs:A) -> A {
    return lhs.mappend(rhs)
}

extension NSAttributedString : Monoid {
    public typealias M = NSAttributedString
    public func mempty() -> M {
        return NSAttributedString()
    }
    
    public func mappend(a:M) -> M {
        let mutable = NSMutableAttributedString(attributedString:self)
        mutable.appendAttributedString(a)
        return NSAttributedString(attributedString: mutable)
    }
}

extension Array : Monoid {
    public typealias M = Array
    public func mempty() -> M {
        return []
    }
    
    public func mappend(a:M) -> M {
        var lhs = Array(self)
        lhs.extend(a)
        return lhs
    }
}

extension Dictionary : Monoid  {
    public typealias M = Dictionary
    public func mempty() -> M {
        return Dictionary()
    }
    
    public func mappend(a:M) -> M {
        var lhs = Dictionary()
        for (key, val) in self {
            lhs.updateValue(val, forKey: key)
        }
        
        for (key, val) in a {
            if !lhs[key] {
                lhs.updateValue(val, forKey: key)
            }
        }
        return lhs
    }
}

