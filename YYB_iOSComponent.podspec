Pod::Spec.new do |s|
  s.name          = "YYB_iOSComponent"
  s.version       = "0.0.13"
  s.summary       = "iOS UI components"
  s.description   = "components for iOS development"
  s.license       = "MIT"
  s.author        = { "Sniper" => "yanyibin.nz@gmail.com" }
  s.platform      = :ios
  s.source        = { :git => "https://github.com/bassamyan/YYB_iOSComponent.git", :tag => "#{s.version}" }
  s.homepage      = "https://github.com/bassamyan/YYB_iOSComponent"
  s.ios.deployment_target = '10.0'

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
  end

  s.subspec 'AlertView' do |alertView|
    alertView.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/AlertView/**/*.{h,m}'
  end

  s.subspec 'Indicator' do |indicator|
    indicator.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/Indicator/**/*.{h,m}'
  end
  
  s.subspec 'NavigationBar' do |navigationBar|
    navigationBar.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/NavigationBar/**/*.{h,m}'
  end

  s.subspec 'PageControl' do |pageControl|
    pageControl.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/PageControl/**/*.{h,m}'
    pageControl.dependency 'YYB_iOSComponent/Category'
  end

  s.subspec 'PlaceholderTextView' do |placeholderTextView|
    placeholderTextView.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/PlaceholderTextView/**/*.{h,m}'
  end

  s.subspec 'RefreshView' do |refreshView|
    refreshView.subspec 'Base' do |base|
      base.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/RefreshView/Base/**/*.{h,m}'
    end
    
    refreshView.subspec 'Category' do |category|
      category.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/RefreshView/Category/**/*.{h,m}'
      category.dependency 'YYB_iOSComponent/RefreshView/Base'
    end

    refreshView.subspec 'Extension' do |extension|
      extension.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/RefreshView/Extension/**/*.{h,m}'
      extension.dependency 'Masonry'
      extension.dependency 'YYB_iOSComponent/RefreshView/Base'
      extension.dependency 'YYB_iOSComponent/RefreshView/Category'
    end
  end

  s.subspec 'ShadowView' do |shadowView|
    shadowView.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/ShadowView/**/*.{h,m}'
    shadowView.dependency 'Masonry'
    shadowView.dependency 'YYB_iOSComponent/Category'
  end

  s.subspec 'ShadowButton' do |shadowButton|
    shadowButton.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/ShadowButton/**/*.{h,m}'
    shadowButton.dependency 'Masonry'
    shadowButton.dependency 'YYB_iOSComponent/Category'
  end

  s.subspec 'Base' do |base|
    base.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/Base/**/*.{h,m}'
    base.dependency 'Masonry'
    base.dependency 'ReactiveObjC'
    base.dependency 'TPKeyboardAvoiding'
    base.dependency 'FDFullscreenPopGesture'
    base.dependency 'YYB_iOSComponent/Category'
    base.dependency 'YYB_iOSComponent/NavigationBar'
  end

  s.subspec 'PhotoBrowser' do |photoBrowser|
    photoBrowser.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/PhotoBrowser/**/*.{h,m}'
    photoBrowser.dependency 'YYB_iOSComponent/Base'
    photoBrowser.dependency 'YYB_iOSComponent/AlertView'
    photoBrowser.dependency 'SDWebImage'
  end

  s.subspec 'PhotoViewController' do |photoViewController|
    photoViewController.source_files = 'YYB_iOSComponent/YYB_iOSComponent/Components/PhotoViewController/**/*.{h,m}'
    photoViewController.dependency 'YYB_iOSComponent/Base'
    photoViewController.dependency 'YYB_iOSComponent/AlertView'
    photoViewController.framework = 'Photos'
  end

end
