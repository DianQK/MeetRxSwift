platform :ios, "8.0"

use_frameworks!

def rx_pods
pod 'RxSwift'
pod 'RxCocoa'
end

def rx_test_pods
pod 'RxTests'
end

def rx_ext_pods
pod 'RxDataSources'
end

def net_pods
pod 'Alamofire'
pod 'RxAlamofire'
end

def model_pods
pod 'ObjectMapper'
end

target 'MeetRxSwift' do
rx_pods
end

target 'MeetRxSwiftAsync' do
    rx_pods
    net_pods
end