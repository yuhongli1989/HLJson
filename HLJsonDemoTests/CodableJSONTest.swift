//
//  CodableJSONTest.swift
//  HLJsonDemoTests
//
//  Created by yunfu on 2019/2/18.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import XCTest

class CodableJSONTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEncode()  {
        var json = JSON([NSNull()])
        _ = try! JSONEncoder().encode(json)
        json = JSON([nil])
        _ = try! JSONEncoder().encode(json)
        let dictionary: [String: Any?] = ["key": nil]
        json = JSON(dictionary)
        _ = try! JSONEncoder().encode(json)
        
        let jsonString1 = """
{
    "a":1,
    "b":null,
    "c":"valueC",
    "d":[1,2,3],
    "e":{"ekey":"evalue","earrkey":[4,"ee",6]},
    "f":"true"
}
"""
        let data = jsonString1.data(using: .utf8)!
        let json2 = try! JSONDecoder().decode(JSON.self, from: data)
        XCTAssertEqual(json2.a.int, 1)
        XCTAssert(json2.b.isNull)
        XCTAssertEqual(json2.c.string, "valueC")
        XCTAssertEqual(json2.d, [1,2,3])
        XCTAssertEqual(json2.d[0], 1)
        XCTAssertEqual(json2.e.ekey, "evalue")
        XCTAssertEqual(json2.f.bool, nil)
        
        
    }

    
    func testJSONEncoder() {
        let dictionary: [String: Any] = ["a": 2, "b": "bbbb", "list": [123, 3,14], "object": ["a1": 10.10, "a2": "value"], "c": true]
        let json = JSON(dictionary)
        
        let encoder = JSONEncoder()
        
        let data = try? encoder.encode(json)
        
        let decoder = JSONDecoder()
        let json2 = try? decoder.decode(JSON.self, from: data!)
        
        XCTAssertEqual(json, json2)
    }
    
}
