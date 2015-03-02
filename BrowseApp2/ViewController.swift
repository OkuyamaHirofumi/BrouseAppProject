//
//  ViewController.swift
//  BrowseApp2
//
//  Created by 奥山博史 on 2015/03/02.
//  Copyright (c) 2015年 奥山博史. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var testField: UITextField!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!

    @IBOutlet weak var forwardButton: UIBarButtonItem!

    @IBOutlet weak var reloadButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startUrl = "http://dotinstall.com"
        if let url = NSURL(string: startUrl){
            let urlRequest = NSURLRequest(URL:url)
            self.webView.loadRequest(urlRequest)
        }
        // Do any additional setup after loading the view, typically from a nib.
        self.backButton.enabled = self.webView.canGoBack
        self.forwardButton.enabled = self.webView.canGoForward
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goBack(sender: AnyObject) {
        self.webView.goBack()
    }
    @IBAction func goForward(sender: AnyObject) {
        self.webView.goForward()
    }
    @IBAction func reload(sender: AnyObject) {
        self.webView.reload()
    }

}

