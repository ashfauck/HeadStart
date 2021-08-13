//
//  PhotoAttachmentViewController.swift
//  
//
//  Created by ashfauck t on 25/12/19.
//  Copyright © 2019 orgware. All rights reserved.
//

import UIKit
import Photos


struct ImageAndInfo {
    var image:UIImage?
    var imageInfo:[AnyHashable : Any]?
}

protocol PhotoAttachmentDelegate: NSObjectProtocol
{
    func getArrayOfImageFromCameraRoll(success:Bool, imageInfos:[ImageAndInfo]?, errorMessage:String?)
}

class PhotoAttachmentViewController: UIViewController
{

    
    // MARK: - Properties
    
    weak var delegate:PhotoAttachmentDelegate? = nil
    var viewModel = PhotoAttachmentViewModel()
    
    // MARK: - IBOutlets
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var cancelBarBtn: UIBarButtonItem!
    
    
    // MARK: - Life cycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setUpCollectionView()
        self.setUpIsMultiSelect()
        self.setUpViewModel()
        
        self.viewModel.checkPhotoLibraryPermission()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        PHPhotoLibrary.shared().register(self)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    
    // MARK: - Set up
    
    func setUpIsMultiSelect()
    {
        if self.viewModel.isMultiSelect
        {
            self.title = "Choose photos"
        }
        else
        {
            self.title = "Choose photo"
        }
    }
    
    fileprivate func setUpCollectionView()
    {
        self.photoCollectionView.register(identifier: PhotoCollectionViewCell.identifier)
    }
    
    func setUpViewModel()
    {
        
        self.viewModel.didUpdateLoading = { (success) in
            
            DispatchQueue.main.async {
                
                if success
                {
                    self.view.showLoadingHUD()
                }
                else
                {
                    self.view.hideLoadingHUD()
                }
            }
        }
        
        self.viewModel.alertMessage = { (message) in
            
            DispatchQueue.main.async {
                self.showAlert(withTitle: nil, message: message)
            }
            
        }
        
        self.viewModel.addedSuccessfully = { (imageInfos) in

            DispatchQueue.main.async
            {
                if let del = self.delegate
                {
                    del.getArrayOfImageFromCameraRoll(success: true, imageInfos: imageInfos, errorMessage: nil)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
        self.viewModel.openCamera = { () in
            
            DispatchQueue.main.async
            {
                self.openCamera()
            }
        }
        
        self.viewModel.permissionDenied = { (message) in
            
            DispatchQueue.main.async
                {
                    if let del = self.delegate
                    {
                        del.getArrayOfImageFromCameraRoll(success: false, imageInfos: nil, errorMessage: message)
                        
                        self.dismiss(animated: true, completion: nil)
                    }
            }
            
        }
        
        self.viewModel.updateView = { () in
            
            DispatchQueue.main.async
            {
                self.photoCollectionView.reloadData()
            }
            
        }
        
    }
    
    func openCamera()
    {
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        
        switch cameraAuthorizationStatus
        {
        case .authorized:
            
            checkCameraAndOpen()
            
            break
            
        case .restricted,.denied:
            
            self.showAlert(withTitle: nil, message: "This app does not have access to camera.\nPlease grant access in Settings > Privacy > Camera")
            
            break
            
        case .notDetermined:
            // Prompting user for the permission to use the camera.
            AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
                if granted
                {
                    self.checkCameraAndOpen()
                    
                    print("Granted access to \(cameraMediaType)")
                }
                else
                {
                    self.showAlert(withTitle: nil, message: "This app does not have access to camera.\nPlease grant access in Settings > Privacy > Camera")

                    print("Denied access to \(cameraMediaType)")
                }
            }
        @unknown default:
            break
        }
        
        
        
    }
    

    
    
    // MARK: - Actions
    
    
    fileprivate func checkCameraAndOpen()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            DispatchQueue.main.async {

                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerController.SourceType.camera
                picker.cameraCaptureMode = .photo
                self.present(picker, animated: true, completion: nil)
                
            }
        }
        else
        {
            self.showAlert(withTitle: "Camera Not Found", message: "This device has no Camera")
        }
    }
    
    @IBAction func dontBtnAction(_ sender: UIButton)
    {
        if self.viewModel.selectedPhotos.count > 0
        {
            self.viewModel.getSelectedImages(assets: self.viewModel.selectedPhotos)
        }
    }
    
    @IBAction func cancelBarBtnAction(_ sender: UIBarButtonItem)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    


}


// MARK: - Extensions

extension PhotoAttachmentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        self.dismiss(animated: true, completion: nil)
    }

   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let imageData = chosenImage.jpegData(compressionQuality: 0.5), let compressedJPGImage = UIImage(data: imageData)
        {
            UIImageWriteToSavedPhotosAlbum(compressedJPGImage, nil, nil, nil)

            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension PhotoAttachmentViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        guard let photos = self.viewModel.allPhotos else { return 0 }
        
        return  photos.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell, let photos = self.viewModel.allPhotos else { return UICollectionViewCell() }

        if indexPath.item == 0
        {
            cell.updateUI(image: #imageLiteral(resourceName: "camera"))
            
            
            cell.imgView.contentMode = .center
        }
        else
        {
            let photo = photos[indexPath.item - 1]
            
            cell.updateUI(asset: photo, imageManager: self.viewModel.imageManager, isContains: self.viewModel.selectedPhotos.contains(photo))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if indexPath.item == 0
        {
            self.viewModel.didSelectCameraOrImage(indexPath: indexPath)
        }
        else
        {
            guard let photos = self.viewModel.allPhotos else { return  }

            
            let obj = photos[indexPath.item - 1]
            
            if !self.viewModel.isMultiSelect
            {
                self.viewModel.getSelectedImages(assets: [obj])
            }
            else
            {
                if !self.viewModel.selectedPhotos.contains(obj)
                {
                    guard self.viewModel.selectedPhotos.count < 10 else
                    {
                        self.showAlert(withTitle: "Maximum 10 photos", message: nil)
                        return
                    }
                    
                    self.viewModel.selectedPhotos.append(obj)
                }
                else
                {
                    self.viewModel.selectedPhotos.remove(object: obj)
                }
                
                collectionView.reloadData()
            }
           
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: (collectionView.frame.size.width - 10) / 3  , height: ( (collectionView.frame.size.width - 10) / 3 ))
    }
    
}

extension PhotoAttachmentViewController: PHPhotoLibraryChangeObserver
{
    
    fileprivate func resetCachedAssets()
    {
        self.viewModel.imageManager.stopCachingImagesForAllAssets()
        self.viewModel.previousPreheatRect = .zero
    }
    
    fileprivate func updateCachedAssets()
    {
        // Update only if the view is visible.
        guard isViewLoaded && view.window != nil  else { return }
        
        guard let photos = self.viewModel.allPhotos else { return }
        
        // The preheat window is twice the height of the visible rect.
        let visibleRect = CGRect(origin: self.photoCollectionView.contentOffset, size: self.photoCollectionView.bounds.size)
        let preheatRect = visibleRect.insetBy(dx: 0, dy: -0.5 * visibleRect.height)
        
        // Update only if the visible area is significantly different from the last preheated area.
        let delta = abs(preheatRect.midY - self.viewModel.previousPreheatRect.midY)
        guard delta > view.bounds.height / 3 else { return }
        
        // Compute the assets to start caching and to stop caching.
        let (addedRects, removedRects) = differencesBetweenRects(self.viewModel.previousPreheatRect, preheatRect)
        let addedAssets = addedRects
            .flatMap { rect in
                self.photoCollectionView.indexPathsForElements(in: rect)
            }
            .map { indexPath in photos.object(at: indexPath.item) }
        let removedAssets = removedRects
            .flatMap { rect in self.photoCollectionView.indexPathsForElements(in: rect) }
            .map { indexPath in photos.object(at: indexPath.item) }
        
        // Update the assets the PHCachingImageManager is caching.
        self.viewModel.imageManager.startCachingImages(for: addedAssets,
                                        targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil)
        self.viewModel.imageManager.stopCachingImages(for: removedAssets,
                                       targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil)
        
        // Store the preheat rect to compare against in the future.
        self.viewModel.previousPreheatRect = preheatRect
    }
    
    fileprivate func differencesBetweenRects(_ old: CGRect, _ new: CGRect) -> (added: [CGRect], removed: [CGRect])
    {
        if old.intersects(new) {
            var added = [CGRect]()
            if new.maxY > old.maxY {
                added += [CGRect(x: new.origin.x, y: old.maxY,
                                 width: new.width, height: new.maxY - old.maxY)]
            }
            if old.minY > new.minY {
                added += [CGRect(x: new.origin.x, y: new.minY,
                                 width: new.width, height: old.minY - new.minY)]
            }
            var removed = [CGRect]()
            if new.maxY < old.maxY {
                removed += [CGRect(x: new.origin.x, y: new.maxY,
                                   width: new.width, height: old.maxY - new.maxY)]
            }
            if old.minY < new.minY {
                removed += [CGRect(x: new.origin.x, y: old.minY,
                                   width: new.width, height: new.minY - old.minY)]
            }
            return (added, removed)
        } else {
            return ([new], [old])
        }
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange)
    {
        guard let photos = self.viewModel.allPhotos, let changes = changeInstance.changeDetails(for: photos) else { return }
        
        DispatchQueue.main.sync {
            
            self.viewModel.allPhotos = changes.fetchResultAfterChanges
            
            if changes.hasIncrementalChanges {
        
                guard let collectionView = self.photoCollectionView else { fatalError() }
                collectionView.performBatchUpdates({
                    
                    if let removed = changes.removedIndexes, !removed.isEmpty
                    {
                        changes.removedObjects.forEach({ (assetsToRemove) in
                            
                            if self.viewModel.selectedPhotos.contains(assetsToRemove)
                            {
                                self.viewModel.selectedPhotos.remove(object: assetsToRemove)
                            }
                        })
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0, execute: {
                            collectionView.reloadData()
                        })
                        collectionView.deleteItems(at: removed.map({ IndexPath(item: $0 + 1, section: 0) }))
                    }
                    
                    if let inserted = changes.insertedIndexes, !inserted.isEmpty {
                        collectionView.insertItems(at: inserted.map({ IndexPath(item: $0 + 1, section: 0) }))
                    }
                    
                    if let changed = changes.changedIndexes, !changed.isEmpty {
                        collectionView.reloadItems(at: changed.map({ IndexPath(item: $0 + 1, section: 0) }))
                    }
                    changes.enumerateMoves { fromIndex, toIndex in
                        collectionView.moveItem(at: IndexPath(item: fromIndex, section: 0),
                                                to: IndexPath(item: toIndex, section: 0))
                    }
                })
            }
            else
            {
                // Reload the collection view if incremental diffs are not available.
                self.photoCollectionView.reloadData()
            }
            resetCachedAssets()
            
            
        }
        
        
    }
}
