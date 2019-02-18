//
//  StringJSONTest.swift
//  HLJsonDemoTests
//
//  Created by yunfu on 2019/2/17.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import XCTest

class StringJSONTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testString(){
        let jsonString1 = """
{
    "a":1,
    "b":null,
    "c":"valueC",
    "d":[1,2,3],
    "e":{"ekey":"evalue","earrkey":[4,"ee",6]}
}
"""
        let jsonString2 = """
[
    {
        "a":null,
        "b":1,
        "c":"str",
        "d":[1,2,3],
        "e":{"ekey":2},
        "f":true
    },
    {
        "a":null,
        "b":2,
        "c":"strc",
        "d":[5,6,7],
        "e":{"ekey":"dddddd"},
        "f":false
    }
]
"""
        let json1:JSON = JSON(jsonString1)
        let json2:JSON = JSON(jsonString2)
        XCTAssert(json1.a.int == 1)
        XCTAssert(json1.b.isNull)
        XCTAssert(json1.c.string == "valueC")
        XCTAssert(json1.d == [1,2,3])
        XCTAssert(json1.d == [1.0,2.0,3.0])
        XCTAssert(json1.e.ekey == "evalue")
        XCTAssert(json1.e.earrkey[0] == 4)
        XCTAssert(json1.e.earrkey[1] == "ee")
        
        XCTAssert(json2[0].a.isNull)
        XCTAssert(json2[0].c == "str")
        XCTAssert(json2[0].f.bool == true)
        XCTAssert(json2[0].f != "true")
    }

    

}
