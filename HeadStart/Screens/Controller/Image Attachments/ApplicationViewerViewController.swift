//
//  ApplicationViewerViewController.swift
//  OS
//
//  Created by ashfauck t on 21/01/20.
//  Copyright © 2020 orgware. All rights reserved.
//

import UIKit
import WebKit

public class ApplicationViewerViewController: UIViewController
{

    // MARK: - Properties

    var webView:WKWebView!
    
    public var url: Any? = nil
    public var titleName:String = ""
    
    // MARK: - IBOutlets
    
    
    // MARK: - Life cycle
    
    public override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = titleName
    }
    
    public override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.webView.reload()
    }
    
    // MARK: - Set up

    public override func loadView()
    {
        super.loadView()
        
        
        let webViewConfig = WKWebViewConfiguration()
        webViewConfig.allowsInlineMediaPlayback = true
        webViewConfig.allowsPictureInPictureMediaPlayback = true

        let mediaTypes:WKAudiovisualMediaTypes = .all
        
        webViewConfig.mediaTypesRequiringUserActionForPlayback = mediaTypes
        
        webView = WKWebView(frame: self.view.frame, configuration: WKWebViewConfiguration())
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = false
        
        self.view = webView

        if url is String,let urlStr = url as? String
        {
            guard let webUrl = urlStr.toURL() else { return }

            self.webView.load(URLRequest(url: webUrl))
        }
        else if url is URL,let webUrl = url as? URL
        {
            self.webView.load(URLRequest(url: webUrl))
        }
        else
        {
            let google = "www.google.com".toURL()
            
            self.webView.load(URLRequest(url: google!))
            
            
        }
    }

    public override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - IBActions
    

}

// MARK: - Extensions

extension ApplicationViewerViewController: WKNavigationDelegate,WKUIDelegate
{
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    {
        self.view.hideLoadingHUD()
    }
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
    {
        self.view.showLoadingHUD()
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error)
    {
        self.view.hideLoadingHUD()
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
           decisionHandler(.allow)

    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
           decisionHandler(.allow)

    }
}
