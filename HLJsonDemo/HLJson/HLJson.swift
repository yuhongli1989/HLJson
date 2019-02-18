//
//  HLJson.swift
//  HLJsonDemo
//
//  Created by 于洪礼 on 2019/2/15.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import UIKit

@dynamicMemberLookup
public struct JSON {
    
    public enum TYPE:Equatable {
        case number(NSNumber)
        case string(String)
        case array([JSON])
        case dictionary([String:JSON])
        case null
        
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
                self = .null
                break
            }
            
        }
    }
    
    public var count:Int{
        switch type {
        case .null:
            return 0
        case .array(let arr):
            return arr.count
        case .number(_):
            return 1
        case .dictionary(let dic):
            return dic.count
        case .string(let str):
            return str.count
        }
    }
    
    
    private(set) var type:TYPE
    
    public init(_ object:Any?) {
        
        if let j = object as? JSON{
            type = j.type
        }else if let str = object as? String,
            let utf8Data = str.data(using: .utf8){
            let json = JSONDecoder()
            if let k = try? json.decode(JSON.self, from: utf8Data){
                type = k.type
            }else{
                type = TYPE(str)
            }
        }else if let data = object as?Data{
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: [])
                type = TYPE(object)
            } catch  {
                type = TYPE.null
            }
        }else{
            type = TYPE(object)
        }

    }
    
}

extension JSON{
    
    public var isNull:Bool{
        return type == TYPE.null
    }
    
    public var int:Int?{
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
                type = .null
            }
        }
    }
    
    public var float:Float?{
        get{
            if case .number(let num) = type{
                return num.floatValue
            }
            return nil
        }
        set{
            if let v = newValue{
                type = .number(NSNumber(value: v))
            }else{
                type = .null
            }
        }
    }
    
    public var double:Double?{
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
                type = .null
            }
        }
    }
    
    public var string:String?{
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
                type = .null
            }
        }
    }
    
    public var bool:Bool?{
        get{
            if case .number(let b) = type{
                return b != 0
            }
            return nil
        }
        set{
            if let b = newValue{
                type = .number(NSNumber(value: b))
            }else{
                type = .null
            }
        }
    }
    
    public var array:[JSON]?{
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
                type = .null
            }
        }
    }
    public var dictionary:[String:JSON]?{
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
                type = .null
            }
        }
    }
}

extension JSON{
    
    public subscript(index:Int)->JSON{
        get{
            if case .array(let arr) = type{
                return (index<arr.count && index>=0) ? arr[index]:JSON(nil)
            }
            return JSON(nil)
        }
        set{
            if case .array(let arr) = type{
                if (index<arr.count && index>=0){
                    var a = arr
                    a[index] = JSON(newValue)
                    type = .array(a)
                }
            }
        }
        
    }
    public subscript(dynamicMember key:String)->JSON{
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
    
    public subscript(key:String)->JSON{
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

extension JSON:Swift.ExpressibleByStringLiteral{
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
    
}

extension JSON: Swift.ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }
}

extension JSON: Swift.ExpressibleByBooleanLiteral {
    
    public init(booleanLiteral value: BooleanLiteralType) {
        self.init(value)
    }
}
extension JSON: Swift.ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: FloatLiteralType) {
        self.init(value)
    }
}

extension JSON: Swift.ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, Any)...) {
        let dictionary = elements.reduce(into: [String: Any](), { $0[$1.0] = $1.1})
        self.init(dictionary)
    }
}

extension JSON: Swift.ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: Any...) {
        self.init(elements)
    }
}



extension JSON:Equatable{

    public static func == (lhs: JSON, rhs: JSON) -> Bool{
        switch (lhs.type,rhs.type) {
        case (.null,.null):
            return true
        case (.number(let lnum),.number(let rnum)):
            return lnum == rnum
        case (.string(let lstr),.string(let rstr)):
            return lstr == rstr
        case (.array(let larr),.array(let rarr)):
            return larr == rarr
        case (.dictionary(let ldic),.dictionary(let rdic)):
            return ldic == rdic
        default:
            return false
        }
    }
}


extension JSON:CustomDebugStringConvertible,CustomStringConvertible{
    
    public var description: String{
        switch type {
        case .null:
            return "null"
        case .number(let num):
            return num.description
        case .array(let arr):
            return arr.description
        case .dictionary(let dic):
            return dic.description
        case .string(let str):
            return str.description
        }
    }
    
    public var debugDescription: String{
        return description
    }
    
}

extension JSON{
    public var stringJson:String?{
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self){
            let str = String(data: data, encoding: .utf8)
            return str
        }else{
            return nil
        }
    }
}


extension JSON:Codable {
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        if case TYPE.null = self.type {
            try container.encodeNil()
            return
        }
        switch type {
        case  .number(let num):
            try container.encode(num.doubleValue)
            break
        case .string(let stringValue):
            try container.encode(stringValue)
            break
        case .array(let arr):
            try container.encode(arr)
            break
        case .dictionary(let dic):
            try container.encode(dic)
            break
        default:
            break
        }
    }
    
    private static var codableTypes: [Codable.Type] {
        return [
            Bool.self,
            Int.self,
            Int8.self,
            Int16.self,
            Int32.self,
            Int64.self,
            UInt.self,
            UInt8.self,
            UInt16.self,
            UInt32.self,
            UInt64.self,
            Double.self,
            Float.self,
            String.self,
            [JSON].self,
            [String: JSON].self
        ]
    }
    
    public init(from decoder: Decoder) throws {
        var object: Any?
        if let container = try? decoder.singleValueContainer(), !container.decodeNil() {
            
            for type in JSON.codableTypes {
                if object != nil {
                    break
                }
                // try to decode value
                switch type {
                case let boolType as Bool.Type:
                    object = try? container.decode(boolType)
                
                case let intType as Int.Type:
                    object = try? container.decode(intType)
                    
                case let int8Type as Int8.Type:
                    object = try? container.decode(int8Type)
                    
                case let int32Type as Int32.Type:
                    object = try? container.decode(int32Type)
                    
                case let int64Type as Int64.Type:
                    object = try? container.decode(int64Type)
                    
                case let uintType as UInt.Type:
                    object = try? container.decode(uintType)
                    
                case let uint8Type as UInt8.Type:
                    object = try? container.decode(uint8Type)
                    
                case let uint16Type as UInt16.Type:
                    object = try? container.decode(uint16Type)
                    
                case let uint32Type as UInt32.Type:
                    object = try? container.decode(uint32Type)
                    
                case let uint64Type as UInt64.Type:
                    object = try? container.decode(uint64Type)
                    
                case let doubleType as Double.Type:
                    object = try? container.decode(doubleType)
                    
                case let stringType as String.Type:
                    object = try? container.decode(stringType)
                    
                case let jsonValueArrayType as [JSON].Type:
                    object = try? container.decode(jsonValueArrayType)

                case let jsonValueDictType as [String: JSON].Type:
                    object = try? container.decode(jsonValueDictType)
                    
                default:
                    break
                }
            }
        }
        self.init(object)
    }
    
}

