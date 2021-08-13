//
//  AttachmentDetailViewController.swift
//  OS
//
//  Created by ashfauck t on 21/01/20.
//  Copyright © 2020 orgware. All rights reserved.
//

import UIKit

class AttachmentDetailViewController: UIViewController {

    // MARK: - Properties
    let imageZoomVC:ImageZoomViewController = {
        
        let imageVC = HSStoryboard.common.instantiateViewController(withIdentifier: "ImageZoomViewController") as! ImageZoomViewController
        
        return imageVC
        
    }()
    
    let webView:ApplicationViewerViewController = {
         
         let vc = HSStoryboard.common.instantiateViewController(withIdentifier: "ApplicationViewerViewController") as! ApplicationViewerViewController
         
         return vc
         
     }()
    
    var pageViewController = UIPageViewController()

    var attachments:[HSAttachment] = []
    var selectedIndex:Int = 0

    
    // MARK: - IBOutlets

    @IBOutlet weak var closeBarBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    
    // MARK: - Life cycle
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        setUpPageviewController()
    }

    // MARK: - Set up
    

    fileprivate func setUpPageviewController()
    {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        self.pageViewController.view.frame = CGRect(origin: CGPoint.zero, size: self.containerView.frame.size)
        
        self.pageViewController.delegate = self
        
        self.pageViewController.dataSource = self
        
        self.pageViewController.setViewControllers([self.viewController(at: selectedIndex)], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
        
        self.addChild(self.pageViewController)
        self.containerView.addSubview(self.pageViewController.view)
        
        self.pageViewController.didMove(toParent: self)
    }
    
    func viewController(at index:Int) -> UIViewController
    {
        let attachment = self.attachments[index]
        
        guard let contentType = attachment.type else  {
            
            if let imageVC = HSStoryboard.common.instantiateViewController(withIdentifier: "ImageZoomViewController") as? ImageZoomViewController
            {
                imageVC.pageId = index
                imageVC.image = attachment.url

                return imageVC
            }
            return UIViewController()
        }

        if contentType.lowercased().contains("image"), let imageVC = HSStoryboard.common.instantiateViewController(withIdentifier: "ImageZoomViewController") as? ImageZoomViewController
        {
            imageVC.pageId = index
            imageVC.image = attachment.url

            return imageVC
        }
        else if contentType.lowercased().contains("application"), let vc = HSStoryboard.common.instantiateViewController(withIdentifier: "ApplicationViewerViewController") as? ApplicationViewerViewController
        {
            vc.pageId = index
            vc.url = attachment.url
            _ = vc.view
            
            return vc
        }
        else if contentType.lowercased().contains("video"), let vc = HSStoryboard.common.instantiateViewController(withIdentifier: "ApplicationViewerViewController") as? ApplicationViewerViewController
        {
            vc.pageId = index
            vc.url = attachment.url
            
            return vc
        }
        else
        {
            return UIViewController()
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func closeBtnAction(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Extensions


extension AttachmentDetailViewController : UIPageViewControllerDelegate,UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
    {
        guard completed else {
            return
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        if self.attachments.count > 1
        {
            var index = viewController.pageId
            
            if index == 0
            {
                return nil
            }
            
            index = index - 1
            
            return self.viewController(at: index)
        }
        else
        {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if self.attachments.count > 1 {
            
            var index = viewController.pageId
            
            index = index + 1
            
            if index == self.attachments.count
            {
                //return self.viewController(at: 0)
                return nil
            }
            
            return self.viewController(at: index)
        }
        else
        {
            return nil
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int
    {
        return 0
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int
    {
        return selectedIndex
    }
}

