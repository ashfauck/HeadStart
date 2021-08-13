//
//  PhotoCollectionViewCell.swift
//
//
//  Created by ashfauck t on 25/12/19.
//  Copyright © 2019 orgware. All rights reserved.
//

import UIKit
import Photos

class PhotoCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        self.imgView.contentMode = .scaleAspectFill
        self.imgView.image = UIImage()
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
     
        self.imgView.borderColor = .clear
        
        self.imgView.borderWidth = 0.0
    }

    func updateUI(image: UIImage)
    {
        self.imgView.image = image
    }
    
    func updateUI(asset: PHAsset?, imageManager: PHCachingImageManager, isContains:Bool)
    {
        if let asset = asset
        {
            let imageRequestOptions = PHImageRequestOptions()
            
            imageRequestOptions.isSynchronous = true
            imageRequestOptions.deliveryMode = .opportunistic
            
            
            imageManager.requestImage(for: asset, targetSize: self.frame.size, contentMode: .aspectFill, options: imageRequestOptions, resultHandler: { image, _ in
                
                if image != nil
                {
                    self.imgView.image = image
                }
                else
                {
                    self.imgView.image = UIImage()
                }
            })
        }
        else
        {
            self.imgView.image = UIImage()
        }
        
        self.imgView.borderColor = isContains ? #colorLiteral(red: 0.137254902, green: 0.5411764706, blue: 0.9294117647, alpha: 1) : .clear
        self.imgView.borderWidth = isContains ? 4.0 : 0.0
        
    }
    
    func updateUI(imgUrl: Any?)
    {
        self.imgView.setDefaultImageCacheUrl(imageType: imgUrl, placeHolderImage: UIImage())
    }
        
    func updateUI(attachment: HSAttachment)
    {
//        guard let type = attachment.type else { return }
        
        let type = "image"
        if type.lowercased().contains("image")
        {
            self.imgView.backgroundColor = .gray

            self.imgView.setImageUrl(url: attachment.url, placeHolderImage: UIImage())
            
            self.imgView.contentMode = .scaleAspectFill
        }
        else
        {
            self.imgView.backgroundColor = UIColor(hex: 0xf2f2f7, alpha: 1.0)

            self.imgView.image = #imageLiteral(resourceName: "fileDocument")
            
            self.imgView.contentMode = .scaleAspectFit
        }
        
        self.imgView.borderColor = .clear
        
        self.imgView.borderWidth = 0.0
        
        self.imgView.cornerRadius = 4.0
    }
    
    

}
