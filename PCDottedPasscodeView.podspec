#
# Be sure to run `pod lib lint PCDottedPasscodeView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PCDottedPasscodeView'
  s.version          = '0.1.3'
  s.summary          = 'A custome dotted passcode view to enable entering numeric passcode.'

  s.description      = <<-DESC
PCDottedPasscodeView enables entering dotted passcode for special reasons such as a 6-digit bank passcode. The dot color/count/size can also be configured through XIB.
                       DESC

  s.homepage         = 'https://github.com/pechn/PCDottedPasscodeView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Peter Chen' => 'chencg.hn@qq.com' }
  s.source           = { :git => 'https://github.com/pechn/PCDottedPasscodeView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PCDottedPasscodeView/Classes/**/*'
end
