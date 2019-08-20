//
//  HSConstants.swift
//  HeadStart
//
//  Created by Ashfauck on 8/20/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation

class HSConstants: NSObject {
    
    static let shared = HSConstants()
    
    var stagingUrl:String = ""
    var testingUrl:String = ""
    var releaseUrl:String = ""
    
    var environment:HSNetworkEnvironment = .release // by default will point release url
    
    
    
    
    
    
}
