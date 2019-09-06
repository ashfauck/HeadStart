//
//  HSConstants.swift
//  HeadStart
//
//  Created by Ashfauck on 8/20/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation

open class HSConstants: NSObject {
    
    public static let shared = HSConstants()
    
    open var stagingUrl:String = ""
    open var testingUrl:String = ""
    open var releaseUrl:String = ""
    
    open var environment:HSNetworkEnvironment = .release // by default will point release url
    open var leftViewWidthSize: CGFloat = UIScreen.main.bounds.size.width * 0.85
    open var rightViewWidthSize: CGFloat = UIScreen.main.bounds.size.width * 0.85
    
    
    open func setLeftViewWidthSize(size:CGFloat)
    {
        self.leftViewWidthSize = size
    }
    
    open func setRightViewWidthSize(size:CGFloat)
    {
        self.rightViewWidthSize = size
    }
    
    
}
