#
#  Be sure to run `pod spec lint YYB_iOSComponent.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name          = "YYB_iOSComponent"
  s.version       = "0.0.1"
  s.summary       = "YYB_iOSComponent."
  s.description   = "A pod for iOS develope components"
  s.license       = "MIT"
  s.author        = { "Sniper" => "yanyibin.nz@gmail.com" }
  s.platform      = :ios
  s.source        = { :git => "https://github.com/bassamyan/YYB_iOSComponent.git", :tag => "#{s.version}" }

  s.subspec 'Category' do |category|
    category.subspec 'Base' do |base|
      base.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/Category/Base/**/*.{h,m}'
    
    category.subspec 'Layout' do |layout|
      layout.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/Category/Layout/**/*.{h,m}'
      layout.dependency 'Masonry'
end
