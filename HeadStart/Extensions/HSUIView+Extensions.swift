//
//  HSUIView+Extensions.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

public enum LAYER_SIDES: Int {
    case LAYER_TOP = 1,
    LAYER_BOTTOM,
    LAYER_LEFT,
    LAYER_RIGHT,
    LAYER_ALL
}

extension UIView {
    
    public func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable public var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable public var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue?.cgColor
        }
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
    }
    
    @IBInspectable public var shadowOffset: CGSize {
        set {
            layer.shadowOffset = newValue
        }
        get {
            return layer.shadowOffset
        }
    }
    @IBInspectable public var shadowOpacity: Float {
        set
        {
            layer.shadowOpacity = newValue
        }
        get
        {
            return layer.shadowOpacity
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat
        {
        set
        {
            layer.masksToBounds = false
            layer.shadowColor = layer.shadowColor
            layer.shadowOpacity = layer.shadowOpacity
            layer.shadowOffset = layer.shadowOffset
            layer.shadowRadius = newValue
            layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale
        }
        get
        {
            return layer.shadowRadius
        }
    }
    @IBInspectable public var startGradiantColor:UIColor? {
        
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.startColor) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.startColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            self.setUpGradiant()
        }
        
    }
    
    @IBInspectable public var endGradiantColor:UIColor? {
        
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.endColor) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.endColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.setUpGradiant()
        }
    }
    
    public func setUpGradiant()  {
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(origin: CGPoint.zero, size: self.frame.size)
        gradient.colors = [
            startGradiantColor?.cgColor ?? UIColor.clear,
            endGradiantColor?.cgColor ?? UIColor.clear
        ]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.72, y: 1.2)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.16)
        gradient.zPosition = -1
        gradient.name = "gradientLayer"
        
        if self is UIButton
        {
            (self as? UIButton)?.layer.insertSublayer(gradient, below: (self as? UIButton)?.imageView?.layer)
        }
        else
        {
            self.layer.insertSublayer(gradient, at: 0)
        }
    }
    
    public func gradiantWithArrayOfColors(colors:[UIColor],startPoint:CGPoint,endPoint:CGPoint,locations:[NSNumber]) -> CAGradientLayer
    {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors.map{ $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.name = "gradientLayer"
        self.layer.insertSublayer(gradient, at: 0)
        
        return gradient
    }
    
    private struct AssociatedKeys {
        static public var startColor : UIColor?
        static public var endColor : UIColor?
    }
    
    public func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
    
    public func currentViewController() -> UIViewController? {
        
        if let rootController = UIApplication.shared.keyWindow?.rootViewController
        {
             var currentController: UIViewController! = rootController
            
            while( currentController.presentedViewController != nil )
            {
                currentController = currentController.presentedViewController
            }
            
            return currentController
        }
        
        return nil
    }
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat)
    {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        self.layoutIfNeeded()
    }
    
    public func layerDrawForView(position:LAYER_SIDES,color:UIColor,layerThickness:CGFloat) -> Void {
        
        let border = CALayer()
        
        border.backgroundColor = color.cgColor
        
        switch position
        {
            
        case .LAYER_TOP:
            
            border.frame = CGRect(x: 0, y:0, width: self.frame.width, height: layerThickness)
            
            break
            
        case .LAYER_RIGHT:
            
            border.frame = CGRect(x: self.frame.size.width - layerThickness, y:0, width: layerThickness, height: self.frame.size.height)
            
            break
            
        case .LAYER_BOTTOM:
            
            border.frame = CGRect(x: 0, y:self.frame.size.height - layerThickness, width: self.frame.width, height: layerThickness)
            
            break
            
        case .LAYER_LEFT:
            
            border.frame = CGRect(x: 0, y:0, width: layerThickness, height: self.frame.size.height)
            
            break
            
        case .LAYER_ALL:
            
            border.frame = self.frame
            
            break
            
        }
        
        self.layer.addSublayer(border)
        
    }
    
    /** Loads instance from nib with the same name. */
    public func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    final public func prepareKeyboardDismissOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnView))
//        tapGesture.cancelsTouchesInView = true
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc public func tappedOnView() {
        self.endEditing(true)
    }
    
    @IBInspectable public var endEditingOnTap: Bool {
        set {
            if newValue == true {
                prepareKeyboardDismissOnTap()
            }
        }
        get {
            return false
        }
    }
    
    @objc public func showDoneBtnOnKeyboard(sourceTextFieldOrtextView:AnyObject) -> Void {
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 44))
        
        toolbar.barStyle = UIBarStyle.default
        
        toolbar.isTranslucent = true
        toolbar.backgroundColor = UIColor.gray// AppColor.grayColor
        let flexibleSpaceRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(tappedOnView))
        
        toolbar.items = [flexibleSpaceRight,doneBtn]
        
        if sourceTextFieldOrtextView is UITextField
        {
            (sourceTextFieldOrtextView as? UITextField)?.inputAccessoryView = toolbar
        }
        else if sourceTextFieldOrtextView is UITextView
        {
            (sourceTextFieldOrtextView as? UITextView)?.inputAccessoryView = toolbar
        }
    }
    
    public func addTapGesture(tapNumber: Int, target: Any, action: Selector)
    {
        let tap = UITapGestureRecognizer (target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    public func showLoadingHUD(loaderType:NVActivityIndicatorType? = nil)
    {
        DispatchQueue.main.async
            {
                guard (self.viewWithTag(-23232323) as? NVActivityIndicatorView) != nil else {

                    let nvActivityLoader = NVActivityIndicatorView(frame: CGRect(origin: CGPoint.zero, size: self.frame.size))

                    if let type = loaderType
                    {
                        nvActivityLoader.type = type
                    }
                    else
                    {
                        nvActivityLoader.type = .ballRotateChase
                    }

                    nvActivityLoader.padding =  self.frame.size.height / 5

                    nvActivityLoader.color = .black

                    nvActivityLoader.tag = -23232323

                    self.addSubview(nvActivityLoader)

                    nvActivityLoader.startAnimating()

                    return
                }

        }
    }

    public func hideLoadingHUD()
    {
        DispatchQueue.main.async
            {
                guard let nvActivityView = self.viewWithTag(-23232323) as? NVActivityIndicatorView
                    else
                {
                    return
                }

                nvActivityView.stopAnimating()

                nvActivityView.removeFromSuperview()
        }
    }
    
    public var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                return parentResponder as? UIViewController ?? nil
            }
        }
        return nil
    }
    
    public func updateConstraint(attribute: NSLayoutConstraint.Attribute, constant: CGFloat) -> Void {
        if let constraint = (self.constraints.filter{$0.firstAttribute == attribute}.first) {
            constraint.constant = constant
            self.layoutIfNeeded()
        }
    }
    
    public func tableAndCollectionViewEmptyMessage(message: String? = nil) {
        
        //        let messageLabel : UILabel = UILabel(frame: CGRect(x: self.frame.width/2, y: self.frame.height/2, width: self.frame.width, height: 30))
        
        let messageLabel : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 30))
        messageLabel.text = message ?? ""
        messageLabel.textColor = UIColor.black
        messageLabel.textAlignment = .center
        self.addSubview(messageLabel)
        messageLabel.center = self.center
        
    }
    
    
    public func dropShadow(show : Bool){
        
        if show == true {
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.3
            layer.shadowOffset = CGSize(width: 5, height: 5)
            layer.shadowRadius = 5
            
            //        obj.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            //        obj.layer.shouldRasterize = true
            //        obj.layer.rasterizationScale = scalb ? UIScreen.main.scale : 1
        }else{
            layer.masksToBounds = true
            layer.shadowColor = UIColor.clear.cgColor
            layer.shadowOpacity = 0
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.shadowRadius = 0
        }
    }
    
    public func addShadow(show : Bool)
    {
        if show == true
        {
            //            let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius)
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.3
            layer.shadowOffset = CGSize(width: 0, height: 1)
            layer.shadowRadius = 2
            //            layer.shadowPath = path.cgPath
            //        obj.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            //        obj.layer.shouldRasterize = true
            //        obj.layer.rasterizationScale = scalb ? UIScreen.main.scale : 1
        }
        else
        {
            layer.masksToBounds = true
            layer.shadowColor = UIColor.clear.cgColor
            layer.shadowOpacity = 0
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.shadowRadius = 0
        }
    }
    
    
    public func createDashedLine(from point1: CGPoint, to point2: CGPoint, color: UIColor, strokeLength: NSNumber, gapLength: NSNumber, width: CGFloat)
    {
        let shapeLayer = CAShapeLayer()

        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineDashPattern = [strokeLength, gapLength]

        let path = CGMutablePath()
        path.addLines(between: [point1, point2])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}
