Pod::Spec.new do |s|
  s.name         = "DBAnimatedTabbar"
  s.version      = "1.0"
  s.summary      = "Animated tabbar"
  s.homepage     = "https://github.com/dibelogrivaya/DBAnimatedTabbar"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Diana Belogrivaya" => "diana.belogrivaya@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "git@github.com:dibelogrivaya/DBAnimatedTabbar.git", :tag => s.version }
  s.subspec 'Animations' do |ss|
    ss.source_files = 'DBAnimatedTabbar/Animations'
  end
  s.source_files  = "DBAnimatedTabbar"
  s.requires_arc = true
end
