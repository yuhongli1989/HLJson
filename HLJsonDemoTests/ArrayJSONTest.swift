//
//  ArrayJSONTest.swift
//  HLJsonDemoTests
//
//  Created by yunfu on 2019/2/17.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import XCTest

class ArrayJSONTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testArray()  {
        let arr = [1.1,2.0,3]
        let json = JSON(arr)
        XCTAssert(json[0] == 1.1)
        XCTAssert(arr.count == json.count)
        XCTAssert(json[1].int == 2)
        XCTAssert(json[2].double == 3)
    }
    
    

}
