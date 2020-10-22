Pod::Spec.new do |s|
  s.name             = "Smile"
  s.summary          = "Emoji in Swift"
  s.version          = "2.1.1"
  s.homepage         = "https://github.com/onmyway133/Smile"
  s.license          = 'MIT'
  s.author           = { "Khoa Pham" => "onmyway133@gmail.com" }
  s.source           = {
    :git => "https://github.com/onmyway133/Smile.git",
    :tag => s.version.to_s
  }
  s.social_media_url = 'https://twitter.com/onmyway133'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.2'

  s.requires_arc = true
  s.source_files = 'Sources/**/*'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }
end
