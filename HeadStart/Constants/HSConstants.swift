//
//  HSConstants.swift
//  HeadStart
//
//  Created by Ashfauck on 8/20/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation

public class HSConstants: NSObject {
    
    static public let shared = HSConstants()
    
    public var stagingUrl:String = ""
    public var testingUrl:String = ""
    public var releaseUrl:String = ""
    
    public var environment:HSNetworkEnvironment = .release // by default will point release url
    public var leftViewWidthSize: CGFloat = UIScreen.main.bounds.size.width * 0.85
    public var rightViewWidthSize: CGFloat = UIScreen.main.bounds.size.width * 0.85
    
    
    
}
