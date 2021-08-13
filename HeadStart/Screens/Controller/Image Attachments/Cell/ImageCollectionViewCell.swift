//
//  ImageCollectionViewCell.swift
//
//
//  Created by Ashfauck on 11/18/19.
//  Copyright © 2019 orgware. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell
{

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    
        self.cornerRadius = 6.0
    }
    
    func updateUI(image:ImageAndInfo)
    {
        self.imgView.image = image.image ?? UIImage()
    }
    
    func updateUI(attachment: HSAttachment)
    {
        self.imgView.setImageUrl(url: attachment.url, placeHolderImage: UIImage())
        self.imgView.contentMode = .scaleAspectFill
    }
    
    

}
