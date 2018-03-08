//
//  Helper.swift
//  CabRider
//
//  Created by Anurag on 05/03/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//

import Foundation
import SystemConfiguration
import Alamofire

class Helper{
    
    static public func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    static public func getAuthHeader(token : String) -> HTTPHeaders{
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        return headers ;
    }
}
