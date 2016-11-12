# Uncomment the next line to define a global platform for your project
  
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, ‘8.0’

target 'SurveysApp' do

  use_frameworks!

  # Pods for SurveysApp

    pod 'ReachabilitySwift', '~> 3'


  target 'SurveysAppTests' do
    inherit! :search_paths
    # Pods for testing
    

  end

end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] =  '3.0'
        end
    end
end
