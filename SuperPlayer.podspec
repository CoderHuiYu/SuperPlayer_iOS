Pod::Spec.new do |spec|
    spec.name = 'SuperPlayer'
    spec.version = '3.3.7'
    spec.license = { :type => 'MIT' }
    spec.homepage = 'https://cloud.tencent.com/product/player'
    spec.authors = { 'annidyfeng' => 'annidyfeng@tencent.com' }
    spec.summary = '超级播放器'
    spec.source = { :git => 'https://github.com/tencentyun/SuperPlayer_iOS.git', :tag => "v#{spec.version}" }

    spec.ios.deployment_target = '11.0'
    spec.requires_arc = true

    spec.dependency 'AFNetworking'
    spec.dependency 'SDWebImage'
    spec.dependency 'Masonry', '~> 1.1.0'

    spec.static_framework = true
    spec.default_subspec = 'Player'

    spec.ios.framework    = ['SystemConfiguration','CoreTelephony', 'VideoToolbox', 'CoreGraphics', 'AVFoundation', 'Accelerate']
    spec.ios.library = 'z', 'resolv', 'iconv', 'stdc++', 'c++', 'sqlite3'

    
    spec.subspec "Player" do |s|
        s.source_files = 'Demo/TXLiteAVDemo/SuperPlayerKit/SuperPlayer/**/*.{h,m}'
        s.private_header_files = 'Demo/TXLiteAVDemo/SuperPlayerKit/SuperPlayer/Utils/TXBitrateItemHelper.h', 'Demo/TXLiteAVDemo/SuperPlayerKit/SuperPlayer/Views/SuperPlayerView+Private.h'
        s.resource = 'Demo/TXLiteAVDemo/SuperPlayerKit/SuperPlayer/Resource/SuperPlayer.bundle'
        s.dependency 'TXLiteAVSDK_Player', '= 8.3.9884'
    end

    spec.frameworks = ["SystemConfiguration", "CoreTelephony", "VideoToolbox", "CoreGraphics", "AVFoundation", "Accelerate"]
    spec.libraries = [
      "z",
      "resolv",
      "iconv",
      "stdc++",
      "c++",
      "sqlite3"
    ]
end