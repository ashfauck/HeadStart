//
//  HSUIImageView+Extensions.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation
import UIKit
import PINRemoteImage

extension UIImageView
{
    public func setGradient(colors : [UIColor]) {
        
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.locations = [0.0, 1.0]
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
    }
    
    public func setImageUrl(url:Any?,placeHolderImage:UIImage?)
    {
        
        guard let url = url else { return }
        
        if url is String, let urlString = url as? String,let imageUrl = urlString.toURL()
        {
            self.pin_setImage(from: imageUrl, placeholderImage: placeHolderImage)
        }
        else if url is URL, let imageUrl = url as? URL
        {
            self.pin_setImage(from: imageUrl, placeholderImage: placeHolderImage)
        }
        else
        {
            self.image = placeHolderImage
        }
        
    }
    
    public func setDefaultImageCacheUrl(imageType:Any?,placeHolderImage:UIImage?)
    {
        let imageUrl:URL
        
        if imageType is URL, let url = imageType as? URL
        {
            imageUrl = url
        }
        else if imageType is String, let url = (imageType as? String)?.toURL()
        {
            imageUrl = url
        }
        else
        {
            return
        }
        
        DispatchQueue.global(qos: .background).async
            {
                let placeholder = UIImage()
                
                DispatchQueue.main.async
                    { [unowned self] in
                        self.image = placeHolderImage
                }
                
                URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
                    
                    guard
                        
                        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                        
                        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                        
                        let data = data, error == nil,
                        
                        let image = UIImage(data: data)
                        
                        else { return }
                    
                    DispatchQueue.main.async()
                        {
                            self.image = image
                    }
                }).resume()
        }
    }
    
    public func checkAndChangeContentSizeOfImage()
    {
        guard let imageViewIage = self.image else { return }
        
        if imageViewIage.size.width > self.bounds.size.width ||
            imageViewIage.size.height > self.bounds.size.height
        {
            self.contentMode = .scaleAspectFit
        }
        else
        {
            self.contentMode = .center
        }
    }

    public func downloadImage(from url: URL, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    public func downloadImage(from link: String, contentMode: UIView.ContentMode) {
        guard let url = URL(string: link) else { return }
        downloadImage(from: url, contentMode: contentMode)
    }
}

extension UIImage
{
    public func resized(withPercentage percentage: CGFloat) -> UIImage?
    {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    public class func outlinedEllipse(size: CGSize, color: UIColor, lineWidth: CGFloat = 1.0) -> UIImage?
    {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(lineWidth)
        // Inset the rect to account for the fact that strokes are
        // centred on the bounds of the shape.
        let rect = CGRect(origin: .zero, size: size).insetBy(dx: lineWidth * 0.5, dy: lineWidth * 0.5)
        context.addEllipse(in: rect)
        context.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public func resizeImage( newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: 250, height: 200))
        self.draw(in: CGRect(origin: .zero, size: CGSize(width: 250, height:200)))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    public func resize(width: CGFloat,height: CGFloat) -> UIImage?
    {
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        self.draw(in: CGRect(origin: .zero, size: CGSize(width: width, height:height)))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
