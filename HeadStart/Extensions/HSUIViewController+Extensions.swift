//
//  HSUIViewController+Extensions.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController:UIPopoverPresentationControllerDelegate {
    
    public func showAlert(withTitle title: String?, message: String?,delay:Double? = nil,completion: (() -> Void)? = nil)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok".localized(), style: .cancel) { (isAction) in
            
            guard let completion = completion else { return }
            
            completion()
        }
        
        alert.addAction(action)
        
        if let del = delay {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + del)
            {
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    
    public func confirmationAlert(withTitle title: String?, message: String?,okBtnName:String? = nil,cancelBtnName:String? = nil,okCompletion: (() -> Void)? = nil,cancelCompletion: (() -> Void)? = nil)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: okBtnName ?? "Ok".localized() , style: .default) { (isAction) in
            
            guard let completion = okCompletion else { return }
            
            completion()
        }
        
        let cancelAction = UIAlertAction(title: cancelBtnName ?? "Cancel".localized(), style: .cancel) { (isCancelAction) in
            
            guard let completion = cancelCompletion else { return }
            
            completion()
        }
        
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private struct AssociatedKeys {
        static var id : Int?
    }
    
    public var pageId: Int {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.id) as? Int ?? 0
        } set {
            objc_setAssociatedObject(self, &AssociatedKeys.id, newValue as Int, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func createViewInPopOverController<T: UIViewController>(viewController:T,frame:CGRect,sourceView:UIView,delegate:UIPopoverPresentationControllerDelegate)
    {
        viewController.modalPresentationStyle = .popover
        
        let popover = viewController.popoverPresentationController!
        popover.delegate = self
        popover.permittedArrowDirections = .unknown
        viewController.preferredContentSize = frame.size
        popover.sourceView = sourceView
        popover.sourceRect = sourceView.bounds
        
        self.present(viewController, animated: true, completion:nil)
    }
    
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle
    {
        return .none
    }
    
    internal func makeViewAsFullScreen()
    {
        let viewFrame:CGRect = self.view.frame
        if viewFrame.origin.y > 0 || viewFrame.origin.x > 0 {
            self.view.frame = UIScreen.main.bounds
        }
    }
    
    public func removeNavigationLine()
    {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    public func showToast(message : String, duration: CGFloat)
    {
        let toastLabel = UILabel(frame: CGRect.zero)
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        
        toastLabel.alpha = 1.0
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0

        toastLabel.layer.cornerRadius = 10;
        toastLabel.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(toastLabel)
        
        let c1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 65)
        let c2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -65)
        let c3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -75)

        self.view.addConstraints([c1,c2,c3])

        UIView.animate(withDuration: TimeInterval(duration), delay: 0.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
