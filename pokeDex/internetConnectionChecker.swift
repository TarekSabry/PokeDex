//
//  internetConnectionChecker.swift
//  pokeDex
//
//  Created by Tarek Sabry on 7/12/17.
//  Copyright © 2017 Tarek Sabry. All rights reserved.
//

import SystemConfiguration

class InternetChecker {
    public class var sharedInstance: InternetChecker {
        struct Singleton {
            static let instance = InternetChecker()
        }
        return Singleton.instance
    }
    
    private init() { }
    
    func internetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    

}
