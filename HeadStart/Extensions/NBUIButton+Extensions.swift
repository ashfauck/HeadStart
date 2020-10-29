//
//  HSUIButton+Extensions.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation
import UIKit

extension UIButton
{
    public func setImageUrl(url:Any?,placeHolderImage:UIImage?)
    {
        
        guard let url = url else { return }

        if url is String
        {
            if let urlString = url as? String,let imageUrl = urlString.toURL()
            {
                self.pin_setImage(from: imageUrl, placeholderImage: placeHolderImage)
            }
        }
        else if url is URL
        {
            if let imageUrl = url as? URL
            {
                self.pin_setImage(from: imageUrl, placeholderImage: placeHolderImage)
            }
        }
    }
    
//    public func setBackgroundImageUrl(url:Any?,placeHolderImage:UIImage?)
//    {
//
//        guard let url = url else { return }
//
//        if url is String
//        {
//            if let urlString = url as? String,let imageUrl = urlString.toURL()
//            {
//                self.sd_setBackgroundImage(with: imageUrl, for: .normal, completed: nil)
//            }
//        }
//        else if url is URL
//        {
//            if let imageUrl = url as? URL
//            {
//                self.self.sd_setBackgroundImage(with: imageUrl, for: .normal, completed: nil)
//            }
//        }
//    }
}

extension UIBarButtonItem {
    private struct AssociatedObject {
        static var key = "action_closure_key"
    }
    
    var actionClosure: (()->Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObject.key) as? ()->Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObject.key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            target = self
            action = #selector(didTapButton(sender:))
        }
    }
    
    @objc public func didTapButton(sender: Any) {
        actionClosure?()
    }
}

extension UILabel
{
    func underline() {
        if let textString = self.text, textString.count > 0
        {
            let attributedString = NSMutableAttributedString(string: textString)
            
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            
            attributedText = attributedString
        }
    }
}
