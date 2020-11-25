//
//  HSUITextField+Extensions.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation
import UIKit


public enum TextFieldKeyboardConfig: Int {
    case email = 1,
    name,
    password,
    username,
    comment,
    phone
}

extension UITextField {
    
    @IBInspectable public var leftPadding: CGFloat {
        set {
            if (newValue > 0) {
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: 1))
                leftView = paddingView;
                leftViewMode = .always
            }
        }
        get {
            return 0.0
        }
    }
    
    @IBInspectable public var rightPadding: CGFloat {
        set {
            if (newValue > 0) {
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: 1))
                rightView = paddingView;
                rightViewMode = .always
            }
        }
        get {
            return 0.0
        }
    }
    
    @IBInspectable public var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    @IBInspectable public var rightImage: UIImage? {
        set (newValue) {
            guard  newValue != nil else {
                return
            }
            self.textFieldView(textField: self, image: newValue!,whichSide: 2)
        }
        get {
            return UIImage()
        }
    }
    
    @IBInspectable public var leftImage: UIImage? {
        
        set (newValue) {
            guard  newValue != nil else {
                return
            }
            self.textFieldView(textField: self, image: newValue!,whichSide: 1)
        }
        get {
            return UIImage()
        }
    }
    
    @IBInspectable public var isNeedBottomLayer:Bool {
        set {
            self.setBottomBorder()
        }
        get {
            return false
        }
    }
    
    @IBInspectable public var bottomLayerBorderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    public func textFieldView(textField:UITextField,image: UIImage,whichSide:Int) -> Void {
        
        let txtImgView : UIView = UIView(frame:CGRect(x: 0, y: 0, width: textField.frame.size.height, height:textField.frame.size.height ) )

        let button = UIButton(type: UIButton.ButtonType.custom)
        
        button.frame = CGRect(x: 0, y: 0, width: textField.frame.size.height, height:textField.frame.size.height)

        button.setImage(image, for: .normal)
        
        txtImgView.backgroundColor = UIColor.clear
        
        button.isUserInteractionEnabled = false

        if whichSide == 1 // Left Side Image
        {
            button.imageView?.contentMode = .scaleAspectFit
            button.contentMode = UIView.ContentMode.center
            button.contentHorizontalAlignment = .center
            
            
            textField.leftView=txtImgView
            textField.leftViewMode=UITextField.ViewMode.always
            textField.leftView?.isUserInteractionEnabled = true
            button.tag = 1
        }
        else if whichSide == 2 // Right Side Image
        {
            button.imageView?.contentMode = .center
            button.contentMode = UIView.ContentMode.center;
            button.contentHorizontalAlignment = .center
            textField.rightView=txtImgView
            textField.rightViewMode=UITextField.ViewMode.always
            textField.rightView?.isUserInteractionEnabled = true
            button.tag = 2
        }
        
        txtImgView.addSubview(button)
    }
    
    public func setBottomBorder()
    {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    public func addIconBeforeOrAfter(before:String,image:UIImage,after:String)
    {
        let imageAttachment =  NSTextAttachment()
        
        imageAttachment.image = image
        
        let imageOffsetY:CGFloat = -5.0;
        
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: self.frame.size.height, height: self.frame.size.height)
        
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        
        let completeText = NSMutableAttributedString(string: before)
        
        completeText.append(attachmentString)
        
        let  textAfterIcon = NSMutableAttributedString(string: after)

        completeText.append(textAfterIcon)
        
        self.textAlignment = .left
        
        self.attributedText = completeText
    }
    
    @IBInspectable var isLeftView: Bool {
        set (newValue)
        {
            leftView?.isUserInteractionEnabled = newValue
        }
        
        get
        {
            return (leftView?.isUserInteractionEnabled)!
        }
    }
    
    @IBInspectable var isRightView: Bool {
        set (newValue)
        {
            self.rightView?.isUserInteractionEnabled = newValue
        }
        
        get
        {
            return (self.leftView?.isUserInteractionEnabled)!
        }
    }
    
    @IBInspectable var isDone: Bool {
        
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
    
    public func datePickerInputView(dateFormat:String,datePickerMode:UIDatePicker.Mode? = nil,date:Date? = nil,minimumDate:Date? = nil,maximumDate:Date? = nil,minimum:Date? = nil,dateLabelText:String? = nil,completionHandler: @escaping (_ datePicker:UIDatePicker) -> Void)
    {
        let datePickerView = UIDatePicker()
        
        
        datePickerView.timeZone = TimeZone(abbreviation: "GMT")
        datePickerView.locale = Locale.current

        datePickerView.backgroundColor = UIColor.gray
        
        if #available(iOS 13.4, *)
        {
            datePickerView.preferredDatePickerStyle = .wheels
        }
        else
        {
            // Fallback on earlier versions
        }

        if let dateMode = datePickerMode
        {
            datePickerView.datePickerMode = dateMode
        }
        else
        {
            datePickerView.datePickerMode = .date
        }
        
        
        if let currentDate = date
        {
            datePickerView.date = currentDate
        }
        
        if let minimumDates = minimumDate
        {
            var gregorianCalendar = Calendar(identifier: .gregorian)
            
            gregorianCalendar.timeZone = TimeZone(abbreviation: "GMT") ?? TimeZone.current
            
            var dateComponent = gregorianCalendar.dateComponents([.day,.month,.year], from: Date())
            
            dateComponent.hour = gregorianCalendar.component(.hour, from: minimumDates) + 1
            dateComponent.minute = gregorianCalendar.component(.minute, from: minimumDates)
            dateComponent.second = 0
            
            if let endTime = gregorianCalendar.date(from: dateComponent)
            {
                datePickerView.date = endTime
            }
            
            datePickerView.minimumDate = minimumDates
        }
        
        if let minimumDate = minimum
        {
            var gregorianCalendar = Calendar(identifier: .gregorian)
            
            gregorianCalendar.timeZone = TimeZone(abbreviation: "GMT") ?? TimeZone.current
            
            var dateComponent = gregorianCalendar.dateComponents([.day,.month,.year], from: Date())
            
            dateComponent.day = gregorianCalendar.component(.day, from: minimumDate) + 1
            
            if let endDa = gregorianCalendar.date(from: dateComponent)
            {
                datePickerView.date = endDa
            }
            
            datePickerView.minimumDate = minimumDate
        }
        
        
        
        
        if let maximumDates = maximumDate
        {
            datePickerView.maximumDate = maximumDates
        }
        
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 44))
        
        toolbar.barStyle = UIBarStyle.default
        
        toolbar.isTranslucent = true
        toolbar.backgroundColor = UIColor.gray
        
        let flexibleSpaceRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: nil)
        doneBtn.actionClosure = {
            
            self.resignFirstResponder()
            completionHandler(datePickerView)
        }
        
        if let centerText = dateLabelText,centerText.count > 0
        {
            let cancelBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: nil, action: nil)
            
            cancelBtn.actionClosure = {
                self.resignFirstResponder()
            }
            let textBtn = UIBarButtonItem(title: centerText, style: .plain, target: nil, action: nil)
            textBtn.tintColor = UIColor.black
            
            toolbar.items = [cancelBtn,flexibleSpaceRight,textBtn,flexibleSpaceRight,doneBtn]
        }
        else
        {
            toolbar.items = [flexibleSpaceRight,doneBtn]
        }
        
        
        self.inputAccessoryView = toolbar
        
        self.inputView = datePickerView
        
    }
    
    struct AssociatedKeys {
        static var textFieldConfigId:Int = 1
    }
    
    
    @IBInspectable public var keyboardConfig: Int {
        
        
        
        get {
            let configId = objc_getAssociatedObject(self, &AssociatedKeys.textFieldConfigId) as? Int
            
            return configId ?? 1
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.textFieldConfigId, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            
            if let config = TextFieldKeyboardConfig(rawValue: newValue)
            {
                prepareWithConfiguration(config)
                
                self.updateBottomLine(config)
            }
        }
        
    }
    
    public func updateBottomLine(_ config: TextFieldKeyboardConfig)
    {
        
        if [TextFieldKeyboardConfig.email, TextFieldKeyboardConfig.username, TextFieldKeyboardConfig.password].contains(config)
        {
            self.addAction(for: UIControl.Event.editingDidBegin)
            {
                self.bottomLayerBorderColor = UIColor.green
            }
            
            self.addAction(for: .editingDidEnd) {
                self.bottomLayerBorderColor = UIColor.yellow
            }
        }
        
    }
    
    private func prepareWithConfiguration(_ config: TextFieldKeyboardConfig) {
        switch config {
        case .email:
            autocapitalizationType = .none
            autocorrectionType = .no
            spellCheckingType = .no
            keyboardType = .emailAddress
            keyboardAppearance = .default
            returnKeyType = .next
            enablesReturnKeyAutomatically = true
            isSecureTextEntry = false
            
        case .name:
            autocapitalizationType = .words
            autocorrectionType = .no
            spellCheckingType = .no
            keyboardType = .default
            keyboardAppearance = .default
            returnKeyType = .next
            enablesReturnKeyAutomatically = true
            isSecureTextEntry = false
            
        case .password:
            autocapitalizationType = .none
            autocorrectionType = .no
            spellCheckingType = .no
            keyboardType = .default
            keyboardAppearance = .default
            returnKeyType = .done
            enablesReturnKeyAutomatically = true
            isSecureTextEntry = true
            
        case .username:
            autocapitalizationType = .none
            autocorrectionType = .no
            spellCheckingType = .no
            keyboardType = .emailAddress
            keyboardAppearance = .default
            returnKeyType = .next
            enablesReturnKeyAutomatically = true
            isSecureTextEntry = false
            
        case .comment:
            autocapitalizationType = .sentences
            autocorrectionType = .default
            spellCheckingType = .yes
            keyboardType = .default
            keyboardAppearance = .default
            returnKeyType = .default
            enablesReturnKeyAutomatically = true
            isSecureTextEntry = false
            
        case .phone:
            autocorrectionType = .no
            spellCheckingType = .no
            keyboardType = .numberPad
            keyboardAppearance = .default
            returnKeyType = .default
            enablesReturnKeyAutomatically = true
            isSecureTextEntry = false
            
        }
    }
    
    
}
