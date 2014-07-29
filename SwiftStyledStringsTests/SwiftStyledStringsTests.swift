//
//  SwiftStyledStringsTests.swift
//  SwiftStyledStringsTests
//
//  Created by Terry Lewis II on 7/28/14.
//  Copyright (c) 2014 Blue Plover Productions LLC. All rights reserved.
//

import UIKit
import XCTest
import SwiftStyledStrings

class SwiftStyledStringsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAppend() {
        let normalDict = [
            NSFontAttributeName             : UIFont.boldSystemFontOfSize(CGFloat(12)),
            NSForegroundColorAttributeName  : UIColor.redColor(),
            NSUnderlineStyleAttributeName   : NSUnderlineStyle.StyleSingle.toRaw()
        ]
        let attribute:StringAttribute = .Font(UIFont.boldSystemFontOfSize(CGFloat(12)))
            <> .FgColor(UIColor.redColor())
            <> .Underline(.StyleSingle)
        
        XCTAssert(normalDict == attribute.attributeDict(), "Should be equal")
    }
    
    func testBuild() {
        let normalDict = [
            NSFontAttributeName             : UIFont.boldSystemFontOfSize(CGFloat(12)),
            NSForegroundColorAttributeName  : UIColor.redColor(),
            NSUnderlineStyleAttributeName   : NSUnderlineStyle.StyleSingle.toRaw()
        ]
        
        let attribute:StringAttribute = .Font(UIFont.boldSystemFontOfSize(CGFloat(12)))
            <> .FgColor(UIColor.redColor())
            <> .Underline(.StyleSingle)
        
        let s1 = attribute.build("This is a string")
        let s2 = NSAttributedString(string:"This is a string", attributes:normalDict)
        XCTAssert(s1 == s2, "Should be equal")
    }
    
}
