//
//  ImageZoomViewController.swift
//  OS
//
//  Created by ashfauck t on 21/01/20.
//  Copyright © 2020 orgware. All rights reserved.
//

import UIKit

public class ImageSaver: NSObject
{
    public static let instance = ImageSaver()
    
    @objc public func writeToPhotoAlbum(image: UIImage?, target: Any? ,selector:Selector)
    {
        guard let img = image else
        {
            return
        }
     
        UIImageWriteToSavedPhotosAlbum(img, target, selector, nil)
    }
}

class ImageZoomViewController: UIViewController
{
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image:Any?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.scrollView.minimumZoomScale = 0.1
        self.scrollView.maximumZoomScale = 6.0
        self.scrollView.backgroundColor  = UIColor.black
        
        setupGestureRecognizer()
        setZoomScale()
     
        updateImage(image: image)
        
        self.scrollView.delegate = self
        self.scrollView.contentSize = self.imageView.bounds.size
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setZoomScale()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    func updateImage(image:Any?)
    {
        guard let photo = self.image else { return }
        
        if photo is UIImage,let originalImage = photo as? UIImage
        {
            self.imageView.image = originalImage
        }
        else if photo is String,let photoStr = photo as? String
        {
            guard let photoUrl = photoStr.toURL() else { return }
            
            //            self.imageView.pin_updateWithProgress = true
            
            self.imageView.setImageUrl(url: photoUrl, placeHolderImage: UIImage())
        }
        else if photo is URL,let photoUrl = photo as? URL
        {
            //            self.imageView.pin_updateWithProgress = true
            self.imageView.setImageUrl(url: photoUrl, placeHolderImage: UIImage())
        }
    }
    
    func setZoomScale()
    {
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.zoomScale = 1.0
    }
    
    func setupGestureRecognizer()
    {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.handleDoubleTap(recognizer:)))
        doubleTap.numberOfTapsRequired = 2
        self.scrollView.addGestureRecognizer(doubleTap)
    }
    
    @objc func handleDoubleTap(recognizer: UITapGestureRecognizer)
    {
        
        if (scrollView.zoomScale > scrollView.minimumZoomScale)
        {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
        else
        {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
    
    @IBAction func downloadBtnAction(_ sender: UIButton)
    {
        ImageSaver.instance.writeToPhotoAlbum(image: self.imageView.image, target: self, selector: #selector(saveError))
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer)
    {
        print("Save finished!")

        if error == nil
        {
            self.showAlert(withTitle: "Photo Saved!!!", message: nil)
        }
        else
        {
            self.showAlert(withTitle: "Unable to save this photo", message: nil)
        }
    }
}





extension ImageZoomViewController: UIScrollViewDelegate
{
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView)
    {
        let imageViewSize = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)

    }
    
}




