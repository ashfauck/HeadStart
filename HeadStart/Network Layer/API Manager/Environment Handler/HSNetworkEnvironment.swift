//
//  HSNetworkEnvironment.swift
//  HeadStart
//
//  Created by Ashfauck Thaminsali on 4/25/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import UIKit

public enum HSNetworkEnvironment
{
    case release
    case staging
    case test
}

public struct EnvironmentManager
{
//    static public var environment:HSNetworkEnvironment {
//
//        #if Test
//            return .test
//        #elseif Stage
//            return .stage
//        #else
//            return .release
//        #endif
//
//
//    }
    
//    #if Test
//    //    // Test environment
//    static public let environment:HSNetworkEnvironment = .test
//    #elseif Stage
//    //    // Stage environment
//    static public let environment:HSNetworkEnvironment = .staging
//    #else
//    //    // Release environment
//    static public let environment:HSNetworkEnvironment = .release
//    #endif
//
    static public var accessToken:String = ""
    static public var environmentBaseURL:String {
        
        switch HSConstants.shared.environment
        {
        case .release:
            return HSConstants.shared.releaseUrl
        case .staging:
            return HSConstants.shared.stagingUrl
        case .test:
            return HSConstants.shared.testingUrl
        }
        
    }
    
}
