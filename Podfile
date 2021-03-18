# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SauceFinder' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
    pod 'SwiftyJSON', '~> 4.0'
pod 'Alamofire', '~> 5.2'
    pod 'RealmSwift'
pod 'AlamofireImage', '~> 4.1'


  # Pods for SauceFinder

end


# For my M1 mac
post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
