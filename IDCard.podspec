
Pod::Spec.new do |s|
  s.name             = 'IDCard'
  s.version          = '1.0'
  s.summary          = 'A swift package for verify China ID card number'

  s.description      = <<-DESC
  纯Swift实现的中国居民身份证号码校验，检查其是否符合国家标准。
  A swift package for verify China ID card number
                       DESC

  s.homepage         = 'https://github.com/bluesky335/IDCard'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '@BlueSky335' => 'chinabluesky335@gmail.com' }
  s.source           = { :git => 'https://github.com/bluesky335/IDCard.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'  
  s.source_files = 'Sources/**/*.swift'
  s.frameworks = 'Foundation'
  s.swift_versions = "5.0"

end
