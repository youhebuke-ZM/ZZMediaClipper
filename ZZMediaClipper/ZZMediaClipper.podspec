Pod::Spec.new do |s|
  s.name = "ZZMediaClipper"
  s.version = "0.1.1"
  s.summary = "\u89C6\u9891\u88C1\u526A,\u56FE\u7247\u88C1\u526A"
  s.authors = {"zz"=>"409775261@qq.com"}
  s.homepage = "https://github.com/youhebuke-ZM/ZZMediaClipperCode"
  s.description = "\u89C6\u9891\u6309\u6BD4\u4F8B\u88C1\u526A\uFF0C\u5206\u65F6\u6BB5\u88C1\u526A\u3002\u62D6\u56FE\u7247\u6309\u9009\u4E2D\u533A\u57DF\u88C1\u526A\uFF0C\u65CB\u8F6C\u89D2\u5EA6\u88C1\u526A\uFF0C\u6309\u6BD4\u4F8B\u88C1\u526A\u3002"
  s.frameworks = "UIKit"
  s.source = { :path => '.' }

  s.ios.deployment_target    = '9.0'
  s.ios.vendored_framework   = 'ios/ZZMediaClipper.framework'
end
