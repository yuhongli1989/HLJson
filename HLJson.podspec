
Pod::Spec.new do |s|


  s.name         = "HLJson"
  s.version      = "1.0.0"
  s.summary      = "JSON数据处理"
  s.swift_version = "4.2"
  s.description  = <<-DESC
JSON 结构体
可以从json字符串创建JSON结构体
json.key 获取数据
number 类型支持 bool double float int array dictionary  转换
                   DESC

  s.homepage     = "https://github.com/yuhongli1989/HLJson"
  s.ios.deployment_target = "8.0"

  s.license      = "MIT"

  s.author             = { "yuhongli" => "753597827@qq.com" }

  s.source       = { :git => "https://github.com/yuhongli1989/HLJson.git", :tag => "#{s.version}" }

  s.source_files  = "HLJsonDemo/HLJson/*.{swift}"

end
