//
//  NumberJSONTest.swift
//  HLJsonDemoTests
//
//  Created by yunfu on 2019/2/16.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import XCTest

class NumberJSONTest: XCTestCase {

    var objects = [Any]()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let a1:Int = 8
        let a2:Int8 = 8
        let a3:Int16 = 8
        let a4:Int32 = 8
        let a5:Int64 = 8
        let a6:Double = 8
        let a7:UInt = 8
        let a8:UInt16 = 8
        let a9:UInt32 = 8
        let a10:Float = 8
        let a11:Float32 = 8
        let a12:Float64 = 8
        objects = [a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12]
    }
    
    func testNumberEqual()  {
        let a1:JSON = JSON(NSNumber(value: 1))
        XCTAssert(a1==1)
        XCTAssert(a1 == true)
        
        let a2:JSON = 1
        XCTAssert(a2==1)
        let a3:JSON = 2.0
        XCTAssert(a3==2.0)
        
        let a4:JSON = JSON(NSNumber(value: 2))
        XCTAssert(a4 != true)
        let a5:JSON = JSON(NSNumber(value: 0))
        XCTAssert(a5 == false)
        let a6:JSON = JSON(NSNumber(value: -1))
        XCTAssert(a6 != true)
        let a7:JSON = JSON(NSNumber(value: true))
        XCTAssert(a7 == 1)
        XCTAssert(a7 == true)
        let a8:JSON = JSON(NSNumber(value: false))
        XCTAssert(a8 == false)
        XCTAssert(a8 == 0)
        for object in objects{
            let a4:JSON = JSON(object)
            XCTAssert(a4 == 8)
        }
        
         
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


}
