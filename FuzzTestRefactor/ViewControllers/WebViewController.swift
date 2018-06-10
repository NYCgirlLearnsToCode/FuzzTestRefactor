//
//  WebViewController.swift
//  FuzzTestRefactor
//
//  Created by Lisa J on 6/10/18.
//  Copyright © 2018 Lisa J. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.startAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        if let url = URL(string: "https://fuzzproductions.com"){
            webView.load(URLRequest(url: url))
            activityIndicator.stopAnimating()
        }
    }
    
    
    
}
