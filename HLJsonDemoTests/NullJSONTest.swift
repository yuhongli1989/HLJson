//
//  NullJSONTest.swift
//  HLJsonDemoTests
//
//  Created by yunfu on 2019/2/16.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import XCTest

class NullJSONTest: XCTestCase {

    var json:JSON!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let url = Bundle(for: NullJSONTest.self).url(forResource: "TestA", withExtension: "json")
        
        let str = try? String(contentsOf: url!)
        
        json = JSON(str)
        print("json===\(json)")
        XCTAssert(json != nil)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    
    func testNillEqual()  {
        XCTAssert(json[0].a1 == JSON(nil))
        XCTAssert(json[0].a2 == 1)
        XCTAssert(json[0].a3 == 1.1)
        XCTAssert(json[0].a4 == "a")
        XCTAssert(json[0].a5[1] == [5,6,7])
        XCTAssert(json[0].a6 == ["a6key":"value"])
    }


}
