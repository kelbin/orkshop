# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
pod 'JSONKit', ‘1.4’
pod 'GoogleMaps', '~> 2.2'
pod 'PaymentKit', :git => 'https://github.com/lmcd/PaymentKit.git'
target 'OrkShoper' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for OrkShoper

  target 'OrkShoperTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'OrkShoperUITests' do
    inherit! :search_paths
    # Pods for testing
  end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
end
