Pod::Spec.new do |s|
  s.name             = 'Dekoter'
  s.version          = '0.3.1'
  s.summary          = "NSCoding's counterpart for Swift structs."
  
  s.description      = <<-DESC
Fills a gap left by the missing NSCoding's support for Swift structs. If you've ever implemented NSCoding, Koting will be familiar to you as well.
                       DESC

  s.homepage         = 'https://github.com/artemstepanenko/Dekoter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Artem Stepanenko' => 'artem.stepanenko.1@gmail.com' }
  s.source           = { :git => 'https://github.com/artemstepanenko/Dekoter.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '9.0'
  s.source_files = 'Dekoter/Classes/**/*'
end
