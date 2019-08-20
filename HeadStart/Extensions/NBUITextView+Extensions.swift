//
//  AFUITextView+Extensions.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Vagus. All rights reserved.
//

import Foundation
import UIKit

extension UITextView
{
    @IBInspectable public var isDone: Bool {
        
        set {
            if newValue == true
            {
                self.showDoneBtnOnKeyboard(sourceTextFieldOrtextView: self)
            }
        }
        
        get {
            return false
        }
        
    }
}
