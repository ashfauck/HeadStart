//
//  HSNSObject+Extensions.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation
import UIKit
import GameplayKit

extension NSObject
{
    public func stackAlertView(withTitle title: String?, message: String?,delay:Double? = nil,completion: (() -> Void)? = nil)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .cancel) { (isAction) in
            
            guard let completion = completion else { return }
            
            completion()
        }
        
        alert.addAction(action)
        
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        
        if let del = delay {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + del)
            {
                alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    public func stackConfirmationAlert(withTitle title: String?, message: String?,okBtnName:String? = nil,cancelBtnName:String? = nil,okCompletion: (() -> Void)? = nil,cancelCompletion: (() -> Void)? = nil)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: (okBtnName == nil) ? "Ok": okBtnName ?? "Ok" , style: .default) { (isAction) in
            
            guard let completion = okCompletion else { return }
            
            completion()
        }
        
        let cancelAction = UIAlertAction(title: (cancelBtnName == nil) ? "Cancel": cancelBtnName ?? "Cancel", style: .default) { (isCancelAction) in
            
            guard let completion = cancelCompletion else { return }
            
            completion()
        }
        
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel =  UIWindow.Level.alert + 1 // 
        alertWindow.makeKeyAndVisible()
        
        DispatchQueue.main.async {
            alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    
    public func randomString(length : Int) -> String {
        let charSet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        let shuffled = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: charSet) as! [Character]
        let array = shuffled.prefix(length)
        return String(array)
    }
    
    
    /// String describing the class name.
    public static var className: String {
        return String(describing: self)
    }
}

extension DispatchQueue
{
    static public func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: ((_ completed:Bool) -> Void)? = nil)
    {
        DispatchQueue.global(qos: .background).async
            {
                background?()
                
                if let completion = completion
                {
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                        completion(true)
                    })
                }
        }
    }
}

extension Double
{
    /// Rounds the double to decimal places value
    public func rounded(toPlaces places:Int) -> Double
    {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension NSMutableData {
    public func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}



//MARK: - UINavigationBar Extension

extension UINavigationBar {
    
    func transparentBackground()  {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
        self.isUserInteractionEnabled = true
    }
    
    func nilTransparentBackground()  {
        self.setBackgroundImage(nil, for: .default)
        self.isTranslucent = false
    }
    
    func setBottomBorderColor(color: UIColor)
    {
        let navigationSeparator = UIView(frame: CGRect(x: 0, y: self.frame.size.height - 0.5, width: self.frame.size.width, height: 0.5))
        navigationSeparator.backgroundColor = color
        navigationSeparator.isOpaque = true
        navigationSeparator.tag = 123
        if let oldView = self.viewWithTag(123) {
            oldView.removeFromSuperview()
        }
        self.addSubview(navigationSeparator)
    }
}

extension UINavigationController {
    
    @IBInspectable var isBarTransparent:Bool {
        set {
            self.navigationBar.transparentBackground()
        }
        get {
            return false
        }
    }
}


public extension UIAlertController
{
    public func show()
    {
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()

        alertWindow.rootViewController?.present(self, animated: true, completion: nil)
    }
}
