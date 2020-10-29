//
//  HSUITableView+Extensions.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation
import UIKit

extension UITableView
{
    
    public func setEmptyMessageText(_ message: String,textColor:UIColor)
    {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = textColor
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
//        messageLabel.font = UIFont(name: AppFont.nunitoRegular, size: 16.0)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }
    
    public func setEmptyMessage(message: String,textColor:UIColor,image:UIImage? = nil, action:Selector? = nil, target:Any? = nil)
    {

//        DispatchQueue.main.async {
//            let emptyDataView = HSEmptyDataSetView(frame: self.frame)
//            emptyDataView.tag = 20002
////            self.addSubview(emptyDataView)
//            self.backgroundView = emptyDataView
//            emptyDataView.updateEmptyData(status: message, textColor: textColor, image: image, target: target, actions: action)
//            self.separatorStyle = .none;
//        }
    }
    
    public func restore()
    {
        DispatchQueue.main.async {
//            if let view = self.viewWithTag(20002)
//            {
//                view.removeFromSuperview()
//            }
            self.backgroundView = nil
            self.separatorStyle = .singleLine
        }
    }
    
    public func checkEmptyRow(rowCount:Int,message:String,textColor:UIColor,image:UIImage? = nil, action:Selector? = nil, target:Any? = nil)
    {
        _ = (rowCount == 0) ? self.setEmptyMessage(message: message, textColor: textColor, image: image, action: action, target: target) : self.restore()
    }
    
    public func reloadDataWithLayout() {
        self.reloadData()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.reloadData()
    }
    
    public func register(identifier:String)
    {
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    public func reloadSectionWithAnimation(indepath:IndexPath,animation:UITableView.RowAnimation? = .automatic)
    {
        DispatchQueue.main.async {
            self.beginUpdates()
            
            if let anim = animation
            {
                self.reloadSections(IndexSet(integer: indepath.section), with: anim)
            }
            else
            {
                self.reloadSections(IndexSet(integer: indepath.section), with: .automatic)
            }
            self.endUpdates()
        }
    }
    
    public func reloadDataInMainThread()
    {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1)
        {
            self.reloadData()
        }
    }
    
    /// Dequeues reusable UITableViewCell using class name for indexPath.
    ///
    /// - Parameters:
    ///   - type: UITableViewCell type.
    ///   - indexPath: Cell location in collectionView.
    /// - Returns: UITableViewCell object with associated class name.
    public func dequeueReusableCell<T: UITableViewCell>(ofType type: T.Type, for indexPath: IndexPath) -> T
    {
        guard let cell = dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T else
        {
            fatalError("Couldn't find UITableViewCell of class \(type.className)")
        }
        
        return cell
    }
}
