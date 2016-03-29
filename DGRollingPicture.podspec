Pod::Spec.new do |s|

  s.name         = "DGRollingPicture"
  s.version      = "0.0.1"
  s.summary      = "DGRollingPicture is a flexible and practical advertising rolling figure."
  s.homepage     = "https://github.com/yandeguangzy/DGRollingPicture"
  s.license      = "MIT"
  s.author             = {
                          "yandeguang" => "754199572@qq.com",
 }
  s.source        = { :git => "https://github.com/yandeguangzy/DGRollingPicture.git", :tag => s.version.to_s }
  s.source_files  = "Rolling/*.{h,m}","Rolling/CustomView/*.{h,m}","Rolling/200.png"
  s.platform      = :ios, '6.0'
  s.requires_arc  = true
  s.dependency "SDWebImage", "~> 3.7.3"

end
