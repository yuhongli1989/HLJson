# HLJson
创建JSON 可以用符合json格式的data创建
比如这个json
{
  "name":"甲",
  "age":100
}

let str = """
{
  "name":"甲",
  "age":100
}
"""
let data = str.data(using: .utf8)!
let json = JSON(data)
assert((json["name"]=="甲")&&(json["name"]==json.name))

        
也可以通过json得到json字符串
let stringJSON = json.stringJson
        
可以通过Dictionary Array 初始化 JSON
        
    
