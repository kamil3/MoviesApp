platform :ios, '11.0'
use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

def shared_pods
    pod 'Alamofire'
    pod 'AlamofireNetworkActivityLogger'
    pod 'Swinject'
    pod 'SwinjectStoryboard'
    pod 'ObjectMapper'
    pod 'SwiftyBeaver'
    pod 'Localize-Swift'
    pod 'Kingfisher'
    #--------Rx------------
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'NSObject+Rx'
    pod 'Action'
end

target 'MoviesApp' do
    shared_pods
end

target 'MoviesAppTests' do
    pod 'RxTest'
    pod 'RxSwift'
    pod 'RxCocoa'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
        end
    end
end
