//
//  DictionaryJSONTest.swift
//  HLJsonDemoTests
//
//  Created by yunfu on 2019/2/17.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import XCTest

class DictionaryJSONTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDic()  {
        let dic:[String : Any] = ["a":1,"b":[2,3],"c":"abc"]
        var json = JSON(dic)
        XCTAssert(json.a == 1)
        XCTAssert(json.b[0] == 2)
        XCTAssert(json.c == "abc")
        XCTAssert(json.dictionary?.count == json.count)
        json.a = 2
        XCTAssert(json.a == 2)
        json.d = "str"
        XCTAssert(json.d == "str")
        XCTAssert(json.b.count == 2)
        json.b.array?.append(4)
        XCTAssert(json.b.count == 3)
        
        let json1:JSON = ["a":1,"b":2,"c":3]
        print(json1.description)
        XCTAssert(json1.a == 1)
        XCTAssert(json1.b == 2)
        XCTAssert(json1.c == 3)
    }
    
    func testDictionaryMutability() {
        let dictionary: [String: Any] = [
            "string": "STRING",
            "number": 9823.212,
            "bool": true,
            "empty": ["nothing"],
            "foo": ["bar": ["1"]],
            "bar": ["foo": ["1": "a"]]
        ]
        
        var json = JSON(dictionary)
        XCTAssertEqual(json["string"], "STRING")
        XCTAssertEqual(json["number"], 9823.212)
        XCTAssertEqual(json["bool"], true)
        XCTAssertEqual(json["empty"], ["nothing"])
        
        json["string"] = "muted"
        XCTAssertEqual(json["string"], "muted")
        
        json["number"] = 9999.0
        XCTAssertEqual(json["number"], 9999.0)
        
        json["bool"] = false
        XCTAssertEqual(json["bool"], false)
        
        json["empty"] = []
        XCTAssertEqual(json["empty"], [])
        
        json["new"] = JSON(["foo": "bar"])
        XCTAssertEqual(json["new"], ["foo": "bar"])
        
        json["foo"]["bar"] = JSON([])
        XCTAssertEqual(json["foo"]["bar"], [])
        
        json["bar"]["foo"] = JSON(["2": "b"])
        XCTAssertEqual(json["bar"]["foo"], ["2": "b"])
    }
    
    

}
