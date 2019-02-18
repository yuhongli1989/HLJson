//
//  ViewController.swift
//  HLJsonDemo
//
//  Created by 于洪礼 on 2019/2/15.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    let jsonString = """
[
    {
        "name": "Home Town Market",
        "aisles": [
            {
                "name": "Produce",
                "shelves": [
                    {
                        "name": "Discount Produce",
                        "product": {
                            "name": "Banana",
                            "points": 200,
                            "description": "A banana that's perfectly ripe."
                        }
                    }
                ]
            }
        ]
    },
    {
        "name": "Big City Market",
        "aisles": [
            {
                "name": "Sale Aisle",
                "shelves": [
                    {
                        "name": "Seasonal Sale",
                        "product": {
                            "name": "Chestnuts",
                            "points": 700,
                            "description": "Chestnuts that were roasted over an open fire."
                        }
                    },
                    {
                        "name": "Last Season's Clearance",
                        "product": {
                            "name": "Pumpkin Seeds",
                            "points": 400,
                            "description": "Seeds harvested from a pumpkin."
                        }
                    }
                ]
            }
        ]
    }
]
"""
    override func viewDidLoad() {
        super.viewDidLoad()
        createFromDictionary()
        
    }

    /*
     data 必须符合json 否则返回 nil
     在网络上获取的data 创建JSON
     */
    func createFromData()  {
        let data = jsonString.data(using: .utf8)!
        let json = JSON(data)
        assert(json[0].name == "Home Town Market")
        
    }
    
    func createFromStringJson()  {
        let json = JSON(jsonString)
        assert(json[0].aisles[0].name == "Produce")
        
    }
    
    func createFromArray()  {
        let arr:[Any] = [1,2,3,"abc"]
        let json = JSON(arr)
        assert(json[3] == "abc")
        
        let json2:JSON = ["a","b","c"]
        assert(json2[0] == "a")
        
    }
    
    func createFromDictionary()  {
        let dic:[String:Any] = ["a":1,"b":1.111,"c":true,"d":"false"]
        let json = JSON(dic)
        assert(json["d"] == "false")
        assert(json["d"] != false)
        assert(json.d == json["d"])
        
        let json1:JSON = ["a":1,"b":2]
        assert(json1.a == json1["a"])
    }

}

