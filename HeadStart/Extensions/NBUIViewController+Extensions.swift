//
//  AFUIViewController+Extensions.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Vagus. All rights reserved.
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
    
    var pageId: Int {
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
    
    public func showToast(message : String, duration: CGFloat) {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        window.addSubview(toastLabel)
        UIView.animate(withDuration: TimeInterval(duration), delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
