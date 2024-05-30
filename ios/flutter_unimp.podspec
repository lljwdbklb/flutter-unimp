#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_unimp.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_unimp'
  s.version          = '0.0.5'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'https://gitcode.com/lljwdbklb'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Who Jun' => 'lljwdbklb@163.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  # s.resources = ["Assets/**/*.{js,ttf,bundle}",'Features/**/**/*.{png,bundle}']
  s.public_header_files = 'Classes/**/*.h'
  # s.vendored_library = ['Libs/*.a', 'Features/Libs/*.a']
  # s.vendored_frameworks = ['Libs/*.framework', 'Features/Libs/*.{framework,xcframework}']
  s.platform = :ios, '12.0'
  s.static_framework = true

  # s.frameworks = 'JavaScriptCore', 'CoreMedia', 'MediaPlayer', 'AVFoundation', 'AVKit', 'GLKit', 'OpenGLES', 'CoreText', 'QuartzCore', 'CoreGraphics', 'QuickLook', 'CoreTelephony', 'AddressBookUI', 'AddressBook', 'CoreVideo', 'AssetsLibrary', 'Photos', 'MetalKit', 'Accelerate', 'CoreLocation', 'MessageUI', 'ImageIO', 'MapKit', 'SystemConfiguration', 'Security', 'AudioToolbox', 'VideoToolbox', 'MobileCoreServices', 'LocalAuthentication', 'CoreBluetooth', 'CoreMotion', 'ExternalAccessory'
  # s.libraries = 'c++', 'iconv', 'z', 'sqlite3'
  
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386', 'OTHER_LDFLAGS' => ['-ObjC','-force_load'] }
  s.dependency 'Flutter'

  s.subspec 'Core' do |ss|
    ss.public_header_files = 'Features/Core/Headers/**/*.{h,swift}'
    ss.source_files = 'Features/Core/Headers/**/*.{h,swift}'
    ss.frameworks = 'UIKit', 'CoreText','JavaScriptCore','WebKit','CoreTelephony','MediaPlayer','QuartzCore','CFNetwork',
    'Foundation','CoreFoundation','CoreGraphics','QuickLook','CoreServices'
    ss.vendored_library = 'Features/Core/Libs/*.{a}'
    ss.vendored_frameworks = 'Features/Core/Libs/*.{framework}'
    ss.resources = 'Features/Core/Resources/*'
    # ss.dependency 'SDWebImage','5.19.2'
    # ss.dependency 'SSZipArchive','2.2.3'
    ss.libraries = 'c++','iconv'
  end

  ### 子模块

  s.subspec 'Accelerometer' do |ss|
    ss.frameworks = 'Accelerate'
    ss.vendored_library = 'Features/Accelerometer/Libs/*.{a}'
  end

  s.subspec 'Audio' do |ss|
    ss.frameworks = 'AVFoundation'
    ss.vendored_library = 'Features/Audio/Libs/*.{a}'
    ss.vendored_frameworks = 'Features/Audio/Libs/*.{framework}'  
  end

  s.subspec 'Camera&Gallery' do |ss|
    ss.public_header_files = 'Features/Camera&Gallery/Headers/**/*.{h,swift}'
    ss.source_files = 'Features/Camera&Gallery/Headers/**/*.{h,swift}'
    ss.resources = 'Features/Camera&Gallery/Resources/*'
    ss.frameworks = 'AssetsLibrary','Photos','CoreMedia','MetalKit','GLKit'
    ss.vendored_library = 'Features/Camera&Gallery/Libs/*.{a}'
  end

  s.subspec 'Contacts' do |ss|
    ss.frameworks = 'AddressBookUI','AddressBook','AVFoundation','CoreVideo','CoreMedia'
    ss.vendored_library = 'Features/Contacts/Libs/*.{a}'
  end

  s.subspec 'File' do |ss|
    ss.vendored_library = 'Features/File/Libs/*.{a}'
  end

  s.subspec 'NativeJS' do |ss|
    ss.vendored_library = 'Features/NativeJS/Libs/*.{a}'
  end

  s.subspec 'Message' do |ss|
    ss.frameworks = 'MessageUI'
    ss.vendored_library = 'Features/Message/Libs/*.{a}'
  end

  s.subspec 'Orientation' do |ss|
    ss.frameworks = 'CoreLocation','CoreMotion'
    ss.vendored_library = 'Features/Orientation/Libs/*.{a}'
  end

  s.subspec 'Proximity' do |ss|
    ss.vendored_library = 'Features/Proximity/Libs/*.{a}'
  end

  s.subspec 'XMLHttpRequest' do |ss|
    ss.vendored_library = 'Features/XMLHttpRequest/Libs/*.{a}'
  end

  s.subspec 'Zip' do |ss|
    ss.vendored_library = 'Features/Zip/Libs/*.{a}'
  end

  s.subspec 'Fingerprint' do |ss|
    ss.frameworks = 'LocalAuthentication'
    ss.vendored_library = 'Features/Fingerprint/Libs/*.{a}'
  end

  s.subspec 'FaceId' do |ss|
    ss.frameworks = 'LocalAuthentication'
    ss.vendored_library = 'Features/Fingerprint/Libs/*.{a}'
  end

  s.subspec 'Sqlite' do |ss|
    ss.libraries = 'sqlite3.0'
    ss.vendored_library = 'Features/Sqlite/Libs/*.{a}'
  end

  s.subspec 'IBeacon' do |ss|
    ss.frameworks = 'CoreBluetooth','CoreLocation'
    ss.vendored_library = 'Features/IBeacon/Libs/*.{a}'
  end

  s.subspec 'BlueTooth' do |ss|
    ss.frameworks = 'CoreBluetooth'
    ss.vendored_library = 'Features/BlueTooth/Libs/*.{a}'
  end

  s.subspec 'LivePusher' do |ss|
    ss.frameworks = 'AVFoundation','QuartzCore',
    'OpenGLES','AudioToolbox','VideoToolbox',
    'Accelerate','CoreMedia','CoreTelephony',
    'SystemConfiguration','CoreMotion'
    ss.vendored_library = 'Features/LivePusher/Libs/*.{a}'
    ss.vendored_frameworks = 'Features/LivePusher/Libs/*.{framework}'
  end

  s.subspec 'Barcode' do |ss|
    ss.public_header_files = 'Features/Barcode/Headers/**/*{.h,.swift}'
    ss.source_files = 'Features/Barcode/Headers/**/*.{h,swift}'
    ss.frameworks = 'AVFoundation','ImageIO','CoreVideo','CoreMedia'
    ss.vendored_library = 'Features/Barcode/Libs/*.{a}'
    ss.libraries = 'iconv.2'
  end

  s.subspec 'Video' do |ss|
    ss.public_header_files = 'Features/Video/Headers/**/*{.h,.swift}'
    ss.source_files = 'Features/Video/Headers/**/*.{h,swift}'
    ss.frameworks = 'AudioToolbox','AVFoundation',
    'CoreGraphics','CoreMedia','VideoToolbox',
    'VideoToolbox','MediaPlayer','MobileCoreServices',
    'OpenGLES','QuartzCore','UIKit'
    ss.resources = 'Features/Video/Resources/*'
    ss.vendored_library = 'Features/Video/Libs/*.{a}'
    ss.vendored_frameworks = 'Features/Video/Libs/*.{framework}'
    ss.libraries = 'c++','z','bz2'
    ss.dependency  'flutter_unimp/Masonry'
    ss.dependency  'IJKPlayerWithSSL'
  end

  s.subspec 'Geolocation' do |ss|
    ss.frameworks = 'CoreLocation'
    ss.vendored_library = 'Features/Geolocation/Libs/*.{a}'
  end

  s.subspec 'Geolocation-Gaode' do |ss|
    ss.frameworks = 'ExternalAccessory','GLKit','security','CoreTelephony','SystemConfiguration'
    ss.vendored_library = 'Features/Geolocation/Gaode/Libs/*.{a}'
    ss.libraries = 'c++','z'
    ss.dependency 'AMapLocation','2.10.0'
    ss.dependency 'AMapSearch', '9.7.0'
    ss.dependency 'flutter_unimp/Geolocation'
  end

  s.subspec 'Map' do |ss|
    ss.frameworks = 'MapKit','CoreLocation','GLKit'
    ss.vendored_library = 'Features/Map/Libs/*.{a}'
  end
  
  s.subspec 'Map-Gaode' do |ss|
    ss.resources = 'Features/Map/Gaode/Resources/*'
    ss.vendored_library = 'Features/Map/Gaode/Libs/*.{a}'
    ss.libraries = 'c++'
    ss.dependency  'AMap3DMap','9.7.0'
    ss.dependency 'flutter_unimp/Masonry'
    ss.dependency 'flutter_unimp/Map'
  end

  s.subspec 'Statistic' do |ss|
    ss.vendored_library = 'Features/Statistic/Libs/*.{a}'
  end

  s.subspec 'Statistic-Umeng' do |ss|
    ss.vendored_library = 'Features/Statistic/Umeng/Libs/*.{a}'
    ss.dependency  'UMCommon','7.4.2'
    ss.dependency  'UMAPM','1.8.4'
    ss.dependency 'flutter_unimp/Statistic'
  end

  s.subspec 'Log' do |ss|
    ss.vendored_library = 'Features/Log/Libs/*.{a}'
  end

  s.subspec 'Canvas' do |ss|
    ss.frameworks = 'OpenGLES'
    ss.vendored_library = 'Features/Canvas/Libs/*.{a}'
  end

  ## 子模块公用依赖

  s.subspec 'Masonry' do |ss|
    ss.public_header_files = 'Features/Masonry/Headers/**/*{.h,.swift}'
    ss.source_files = 'Features/Masonry/Headers/**/*.{h,swift}'
    ss.vendored_frameworks = 'Features/Masonry/Libs/*.{framework}'
  end

end
