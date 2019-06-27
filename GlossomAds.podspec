Pod::Spec.new do |s|

  s.name         = "GlossomAds"
  s.version      = "2.0.0"
  s.summary      = "GlossomAdsはプロモーション効果の最大化とメディア収益の拡大を両立させた
安心/安全な広告配信を目指す動画アドネットワークです"

  s.homepage     = "https://www.glossom.co.jp"

  s.license      = { :type => 'Copyright', :text => 'Copyright ADFULLY Inc. All rights reserved.' }

  s.author          = "Glossom Inc."

  s.platform        = :ios, "8.0"

  s.source       = { :git => "https://github.com/glossom-dev/GlossomAds-iOS.git", :tag => "#{s.version}" }

  s.vendored_frameworks = "**/GlossomAds.framework"

  s.frameworks = 'AdSupport', 'AVFoundation', 'CoreGraphics', 'CoreMedia', 'CoreTelephony', 'MediaPlayer', 'StoreKit', 'SystemConfiguration', 'SafariServices', 'UIKit', 'WebKit'
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => ['-ObjC', '-fobjc-arc'] }

end
