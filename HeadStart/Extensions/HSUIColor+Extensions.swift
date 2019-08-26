//
//  HSUIColor+Extensions.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation
import UIKit



extension UIColor {
    
    public convenience init(hex:UInt32, alpha:CGFloat = 1.0)
    {
        self.init(
            red:   CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat((hex & 0x0000FF) >> 0)  / 255.0,
            alpha: alpha
        )
    }
    
    public var appColor: UIColor {
        return UIColor.blue// AppColor.themeColor
    }
    
    
    
}
