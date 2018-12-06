Pod::Spec.new do |s|

  s.name         = "GlossomAds"
  s.version      = "1.10.0"
  s.summary      = "GlossomAdsはプロモーション効果の最大化とメディア収益の拡大を両立させた
安心/安全な広告配信を目指す動画アドネットワークです"

  s.homepage     = "https://www.glossom.co.jp"

  s.license      = { :type => 'Copyright', :text => 'Copyright ADFULLY Inc. All rights reserved.' }

  s.author          = "Glossom Inc."

  s.platform        = :ios, "7.0"

  s.source       = { :git => "https://github.com/glossom-dev/GlossomAds-iOS.git", :tag => "#{s.version}" }

  s.vendored_frameworks = "**/GlossomAds.framework"

end
