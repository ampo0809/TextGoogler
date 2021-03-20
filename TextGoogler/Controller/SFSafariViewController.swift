//
//  SFSafariViewController.swift
//  TextGoogler
//
//  Created by Nacho Ampuero on 10.06.20.
//  Copyright © 2020 Nacho Ampuero. All rights reserved.
//

import UIKit
import WebKit

class SFSafariViewController: UIViewController {
    
    var webView: WKWebView!
    var destinationUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWebView(with: destinationUrl!)
        print(destinationUrl!)
    }
}

//MARK: - Trigger WebView

extension SFSafariViewController: WKUIDelegate {
    
    func loadWebView(with urlFromPic: URL) {
        prepareForWebView()
        let myRequest = URLRequest(url: urlFromPic)
        webView.load(myRequest)
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func prepareForWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    // Source: https://developer.apple.com/documentation/webkit/wkwebview
}