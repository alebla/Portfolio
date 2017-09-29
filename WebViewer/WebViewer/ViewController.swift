//
//  ViewController.swift
//  WebViewer
//
//  Created by Alex Blanchard on 9/27/17.
//  Copyright © 2017 Alex Blanchard. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
  var webView: WKWebView!
  var progressView: UIProgressView!
  var websites = ["apple.com", "hackingwithswift.com"]
  
  // Sets the delegate and initializes the webView variable
  override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
  }
  
  // creates the webViewer UI and loads/displays the first allowed site in websites[0]
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let url = URL(string: "https://" + websites[0])!
    webView.load(URLRequest(url: url))
    webView.allowsBackForwardNavigationGestures = true
    webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
    let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
    progressView = UIProgressView(progressViewStyle: .default)
    progressView.sizeToFit()
    let progressButton = UIBarButtonItem(customView: progressView)
    
    toolbarItems = [progressButton, spacer, refresh]
    navigationController?.isToolbarHidden = false
  }
  
  // Called when the user taps open to navigate the allowed sites
  @objc func openTapped() {
    let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
    
    for website in websites {
      ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
    }
    
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
    present(ac, animated: true)
  }
  
  // Called by openTapped and passed the correlating UIAlertAction's title value
  func openPage(alert: UIAlertAction) {
    let url = URL(string: "https://www." + alert.title!)
    webView.load(URLRequest(url: url!))
  }
  
  // Sets the title for the successfully loaded url
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    title = webView.title
  }
  
  // Blocks the user from leaving the domain of allowed sites
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    let url = navigationAction.request.url
    
    if let host = url?.host {
      for website in websites {
        if host.range(of: website) != nil {
          decisionHandler(.allow)
          return
        }
      }
    }
    // Displays alert
    let ac = UIAlertController(title: "Access Denied", message: "You've clicked a link that isn't relevant to this app!", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Continue", style: .cancel))
    present(ac, animated: true)
    decisionHandler(.cancel)
    return
  }
  
  // KVO observes the estimatedProgress value and updates the loading toolbar item
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
      progressView.progress = Float(webView.estimatedProgress)
    }
  }
  
}

