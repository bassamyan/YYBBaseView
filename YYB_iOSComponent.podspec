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
  s.version       = "0.0.2"
  s.summary       = "YYB_iOSComponent."
  s.description   = "A pod for iOS develope components"
  s.license       = "MIT"
  s.author        = { "Sniper" => "yanyibin.nz@gmail.com" }
  s.platform      = :ios
  s.source        = { :git => "https://github.com/bassamyan/YYB_iOSComponent.git", :tag => "#{s.version}" }
  s.homepage      = "https://github.com/bassamyan/YYB_iOSComponent"

  s.subspec 'Category' do |category|
    category.subspec 'Base' do |base|
      base.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/Category/Base/**/*.{h,m}'
    end
    
    category.subspec 'Layout' do |layout|
      layout.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/Category/Layout/**/*.{h,m}'
      layout.dependency 'Masonry'
    end
  end

  s.subspec 'Router' do |router|
    router.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/Router/**/*.{h,m}'

  s.subspec 'AlertView' do |alertView|
    alertView.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/AlertView/**/*.{h,m}'

  s.subspec 'Indicator' do |indicator|
    indicator.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/Indicator/**/*.{h,m}'

  s.subspec 'Navigationbar' do |navigationbar|
    navigationbar.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/Navigationbar/**/*.{h,m}'

  s.subspec 'PageControl' do |pageControl|
    pageControl.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/PageControl/**/*.{h,m}'

  s.subspec 'PlaceholderTextView' do |placeholderTextView|
    placeholderTextView.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/PlaceholderTextView/**/*.{h,m}'

  s.subspec 'RefreshView' do |refreshView|
    refreshView.subspec 'Base' do |base|
      base.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/RefreshView/Base/**/*.{h,m}'
    end
    
    refreshView.subspec 'Category' do |category|
      category.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/RefreshView/Category/**/*.{h,m}'
      category.dependency 'RefreshView/Base'
    end

    refreshView.subspec 'Extension' do |extension|
      extension.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/RefreshView/Extension/**/*.{h,m}'
      extension.dependency 'Masonry'
      extension.dependency 'RefreshView/Base'
      extension.dependency 'RefreshView/Category'
    end

    s.subspec 'ShadowView' do |shadowView|
      shadowView.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/ShadowView/**/*.{h,m}'

    s.subspec 'ShadowButton' do |shadowButton|
      shadowButton.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/ShadowButton/**/*.{h,m}'

  end
end
