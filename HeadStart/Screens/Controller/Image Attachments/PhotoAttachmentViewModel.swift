//
//  PhotoAttachmentViewModel.swift
//
//
//  Created by ashfauck t on 25/12/19.
//  Copyright © 2019 orgware. All rights reserved.
//

import UIKit
import Photos

public class PhotoAttachmentViewModel: NSObject
{
    
    public var allPhotos: PHFetchResult<PHAsset>? = nil
    public var selectedPhotos:[PHAsset] = []

    public lazy var imageManager: PHCachingImageManager = {
        return PHCachingImageManager()
    }()

    public var previousPreheatRect = CGRect.zero
    public var isMultiSelect:Bool = false
    public var didUpdateLoading:((_ success:Bool)->())?
    public var alertMessage:((_ message:String)->())?
    public var permissionDenied:((_ message:String)->())?
    public var updateView:(()->())?
    public var addedSuccessfully:((_ imageInfos: [ImageAndInfo]) -> ())?
    public var openCamera:(()->())?

    
    
    public override init()
    {
        super.init()
    }
    
    
    
    
    public func checkPhotoLibraryPermission()
    {
        switch PHPhotoLibrary.authorizationStatus()
        {
        case .authorized:
            
            setUpFetchOptions()
            
            break
        case .denied, .restricted:

            self.permissionDenied?("This app does not have access to photos.\n Please grant access in Settings > Privacy > Photos")
            
            break
        case .notDetermined:
            // ask for permissions
            
            PHPhotoLibrary.requestAuthorization { (authorizationStatus) in
                if authorizationStatus == .authorized
                {
                    self.setUpFetchOptions()
                }
                else
                {
                    self.permissionDenied?("This app does not have access to photos.\nPlease grant access in Settings > Privacy > Photos")
                }
            }
            
            break
        case .limited:
            break
        @unknown default:
            break
        }
    }
    
    
    fileprivate func setUpFetchOptions()
    {
        if PHPhotoLibrary.authorizationStatus() == .authorized
        {
            let allPhotosOptions = PHFetchOptions()
            
            allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            
            allPhotosOptions.includeAssetSourceTypes = .typeUserLibrary
            
            allPhotosOptions.includeHiddenAssets = true
            
            self.allPhotos = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: allPhotosOptions)
            
            self.updateView?()
        }
    }
    
    public func getSelectedImages(assets: [PHAsset?])
    {
        
        var imageAndInfoArray:[ImageAndInfo] = []
        
        assets.forEach { (assetObj) in
            
            guard let asset = assetObj else { return }
            
            let option = PHImageRequestOptions()
            
            option.isSynchronous = true
            option.isNetworkAccessAllowed = true
            
            self.imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.default, options: option, resultHandler: { (image, imageInfo) in
                
                imageAndInfoArray.append( ImageAndInfo(image: image, imageInfo: imageInfo))
            })
        }
        
        self.addedSuccessfully?(imageAndInfoArray)
    }
    
    public func didSelectCameraOrImage(indexPath:IndexPath)
    {
        var asset:PHAsset? = nil;
        
        if indexPath.item == 0
        {
            asset = nil
        }else
        {
            guard let photos = self.allPhotos else { return }
            
            let photo = photos[indexPath.item - 1]
            
            asset = photo
        }
        
        if asset != nil {
            
            guard let asset = asset else { return }
            
            imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.default, options: nil, resultHandler: { (image, imageInfo) in
                
                self.addedSuccessfully?([ImageAndInfo(image: image, imageInfo: imageInfo)])
            })
        }
        else
        {
            self.openCamera?()
        }
    }
}

