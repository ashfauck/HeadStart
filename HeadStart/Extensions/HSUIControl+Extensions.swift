//
//  HSUIControl+Extensions.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation
import UIKit

public class Closure {
    @objc public let closure: ()->()
    
    public init (_ closure: @escaping ()->()) {
        self.closure = closure
    }
    
    @objc public func invoke () {
        closure()
    }
}

extension UIControl {
    public func addAction (for controlEvents: UIControl.Event, _ closure: @escaping ()->()) {
        let sleeve = Closure(closure)
        addTarget(sleeve, action: #selector(Closure.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
