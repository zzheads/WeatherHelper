source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11'
use_frameworks!

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["ONLY_ACTIVE_ARCH"] = "YES"
    end
  end
end

target 'WeatherHelper' do
  pod 'Alamofire', '~> 5.2'
  pod 'Swinject'
  pod 'SnapKit'
  pod 'Firebase/Analytics'
  pod 'Firebase/Database'
  pod 'Firebase/Auth'
end
