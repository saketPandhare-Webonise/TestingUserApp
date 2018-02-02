//
//  Reachability.swift
//  GymShim


import Foundation
import SystemConfiguration
import EZSwiftExtensions

public class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    //MARK : Internet connectivity
    static func internetCheckDependentCallWith(method : (()->())?) {
        if Reachability.isConnectedToNetwork() {
            if method != nil {
                method!()
            }
        }
        else {
            guard let currentMainWindow = UIApplication.sharedApplication().keyWindow else {
                return
            }
            CommonHelper().showToastMessageOn(currentMainWindow,message: WebServiceErrors.INTERNET_FAILURE_MESSAGE)
        }
    }
}
