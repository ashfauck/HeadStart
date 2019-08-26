//
//  HSUIImage+Extensions.swift
//  HeadStart
//
//  Created by Ashfauck Thaminsali on 7/5/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation
import UIKit


public enum ImageFormat {
    case png
    case jpeg(CGFloat)
}

extension UIImage {
    public func toBase64(format: ImageFormat) -> String? {
        var imageData: Data?
        
        switch format {
        case .png:
            imageData = self.pngData()
        case .jpeg(let compression):
            imageData = self.jpegData(compressionQuality: compression)
        }
        
        return imageData?.base64EncodedString()
    }
}
