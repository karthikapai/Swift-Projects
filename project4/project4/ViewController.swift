//
//  ViewController.swift
//  project4
//
//  Created by Karthika S Pai on 7/20/16.
//  Copyright © 2016 cherryblossom. All rights reserved.
//

import UIKit
import WebKit


class ViewController: UIViewController, WKNavigationDelegate {

  var webView: WKWebView!
  var progressView: UIProgressView!
  var websites = ["apple.com", "google.com"]
  override func loadView()
  {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let url = NSURL(string: "https://" + websites[1])!
    webView.loadRequest(NSURLRequest(URL:url))
    webView.allowsBackForwardNavigationGestures = true
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .Plain,
                                                        target: self, action: #selector(openTapped))
    
    webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
    
    
    
    progressView = UIProgressView(progressViewStyle: .Default)
    progressView.sizeToFit()
    let progressButton = UIBarButtonItem(customView: progressView)
    let spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
    let refresh = UIBarButtonItem(barButtonSystemItem: .Refresh, target: webView, action: #selector(webView.reload))
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    toolbarItems = [progressButton, spacer, refresh]
    navigationController?.toolbarHidden = false
  }

  override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    if keyPath == "estimatedProgress"
    {
      progressView.progress = Float(webView.estimatedProgress)
    }
  }
  
  func openTapped()
  {
    let ac = UIAlertController(title: "Open Page", message: nil, preferredStyle: .ActionSheet)
    for website in websites{
      ac.addAction(UIAlertAction(title: website, style: .Default, handler: openPage))
    }
    ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
    
    presentViewController(ac, animated: true, completion: nil)
    
  }
  
  func openPage(action: UIAlertAction!)
  {
    let url = NSURL(string: "https://" + action.title!)!
    webView.loadRequest(NSURLRequest(URL: url))
  }
  
  
  
  func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
    title = webView.title
  }
  
  func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
    let url = navigationAction.request.URL
    
    if let host = url!.host{
      for website in websites{
        if host.rangeOfString(website) != nil{
          decisionHandler(.Allow)
          return
        }
      }
    }
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

