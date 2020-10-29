//
//  HSUITextView+Extensions.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
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

    @IBInspectable public var placeHolderText:String
    {
        set
        {
            self.setPlaceholder(placeholder: newValue)
        }
        get
        {
            if let placeholderLabel = self.viewWithTag(900909) as? UILabel
            {
                return placeholderLabel.text ?? ""
            }
            else
            {
                return ""
            }
        }
    }
    
    func setPlaceholder(placeholder: String)
    {
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholder
        placeholderLabel.font = self.font!
        placeholderLabel.sizeToFit()
        placeholderLabel.tag = 900909
        placeholderLabel.frame = CGRect(origin: CGPoint(x: 5, y: 5), size: CGSize(width: self.frame.size.width - 10, height: self.frame.size.height - 10))
        placeholderLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !self.text.isEmpty
        placeholderLabel.numberOfLines = 0
        placeholderLabel.sizeToFit()
        self.addSubview(placeholderLabel)
    }

    func checkPlaceholder()
    {
        if let placeholderLabel = self.viewWithTag(900909) as? UILabel
        {
            placeholderLabel.isHidden = !self.text.isEmpty
        }
        
    }

}

class PlaceTextView: UITextView
{
    
    override func awakeFromNib()
    {
        super.awakeFromNib()

        NotificationCenter.default.addObserver(self, selector: #selector(self.textDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    override var text: String!
    {
        didSet
        {
            self.checkPlaceholder()
        }
    }
    
    @objc func textDidChange()
    {
        self.checkPlaceholder()
    }
}
