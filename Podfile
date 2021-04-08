# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/CalebThePerson/Swift-SauceNao-Pod.git'

target 'SauceFinder' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
    pod 'SwiftyJSON', '~> 4.0'
#pod 'Alamofire', '~> 5.2'
  pod 'RealmSwift', '=10.7.2'
pod 'AlamofireImage', '~> 4.1'
pod 'Swift-SauceNao',:git => "https://github.com/CalebThePerson/Swift-SauceNao-Pod.git"




  # Pods for SauceFinder

end


post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end

