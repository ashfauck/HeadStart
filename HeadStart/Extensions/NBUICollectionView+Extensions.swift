//
//  AFUICollectionView+Extensions.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Vagus. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView
{
    public func indexPathsForElements(in rect: CGRect) -> [IndexPath]
    {
        let allLayoutAttributes = collectionViewLayout.layoutAttributesForElements(in: rect)!
        return allLayoutAttributes.map { $0.indexPath }
    }
    
    public func register(identifier:String)
    {
        self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    public func setEmptyMessage(_ message: String,textColor:UIColor)
    {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = textColor
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
//        messageLabel.font = UIFont(name: AppFont.appFontRegular, size: 16.0)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
    }
    
    public func restore()
    {
        self.backgroundView = nil
    }
    
    public func checkEmptyRow(rowCount:Int,message:String,textColor:UIColor)
    {
        _ = (rowCount == 0) ? self.setEmptyMessage(message,textColor:textColor) : self.restore()
    }
    
    
}
