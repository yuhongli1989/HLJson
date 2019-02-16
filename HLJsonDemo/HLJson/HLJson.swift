//
//  HLJson.swift
//  HLJsonDemo
//
//  Created by 于洪礼 on 2019/2/15.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import UIKit

@dynamicMemberLookup
struct JSON {
    
    enum `Type` {
        case number(NSNumber)
        case string(String)
        case array([JSON])
        case dictionary([String:JSON])
        case nill
        
        init(_ object:Any?){
            switch object {
            case let num as NSNumber:
                self = .number(num)
                break
            case let str as String:
                self = .string(str)
                break
            case let arr as [Any]:
                let a = arr.map{JSON($0)}
                self = .array(a)
                break
            case let dic as [String:Any]:
                var d = [String:JSON](minimumCapacity: dic.count)
                for (key,value) in dic{
                    d.updateValue(JSON(value), forKey: key)
                }
                self = .dictionary(d)
                break
            default:
                self = .nill
                break
            }
            
        }
    }
    
    private(set) var type:Type
    
    public init(_ object:Any?) {
        type = Type(object)
        
    }
    
    init(_ data:Data) {
        let object:Any?
        do {
            object = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch  {
            object = nil
        }
        self.init(object)
    }
}

extension JSON{
    var int:Int?{
        get{
            if case .number(let num) = type{
                return num.intValue
            }
            return nil
        }
        set{
            if let v = newValue{
                type = .number(NSNumber(value: v))
            }else{
                type = .nill
            }
        }
    }
    
    var double:Double?{
        get{
            if case .number(let num) = type{
                return num.doubleValue
            }
            return nil
        }
        set{
            if let v = newValue{
                type = .number(NSNumber(value: v))
            }else{
                type = .nill
            }
        }
    }
    
    var string:String?{
        get{
            if case .string(let str) = type{
                return str
            }
            return nil
        }
        set{
            if let str = newValue{
                type = .string(str)
            }else{
                type = .nill
            }
        }
    }
    var array:[JSON]?{
        get{
            if case .array(let arr) = type{
                return arr
            }
            return nil
        }
        set{
            if let arr = newValue{
                type = .array(arr)
            }else{
                type = .nill
            }
        }
    }
    var dictionary:[String:JSON]?{
        get{
            if case let .dictionary(dic) = type{
                return dic
            }
            return nil
        }
        set{
            if let dic = newValue{
                type = .dictionary(dic)
            }else{
                type = .nill
            }
        }
    }
}

extension JSON{
    subscript(index:Int)->JSON{
        get{
            if case .array(let arr) = type{
                return (index<arr.count && index>=0) ? arr[index]:JSON(nil)
            }
            return JSON(nil)
        }
//        set{
//            
//        }
        
    }
    subscript(dynamicMember key:String)->JSON{
        get{
            if case .dictionary(let dic) = type{
                return dic[key] ?? JSON(nil)
            }
            return JSON(nil)
        }
        set{
            if case let .dictionary(dic) = type{
                var d = dic
                d.updateValue(newValue, forKey: key)
                type = .dictionary(d)
            }
        }
    }
}
