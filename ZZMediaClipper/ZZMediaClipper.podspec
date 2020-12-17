Pod::Spec.new do |s|
  s.name = "ZZMediaClipper"
  s.version = "1.0.0"
  s.summary = "视频裁剪，图片裁剪"
  s.authors = {"zz"=>"409775261@qq.com"}
  s.homepage = "https://github.com/youhebuke-ZM/ZZMediaClipper"
  s.description = "视频裁剪，图片裁剪,可旋转角度，缩放，调整比例"
  s.source = { :path => '.' }

  s.ios.deployment_target    = '9.0'
  s.ios.vendored_framework   = 'ZZMediaClipper.framework'
end
