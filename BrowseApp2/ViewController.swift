//
//  ViewController.swift
//  BrowseApp2
//
//  Created by 奥山博史 on 2015/03/02.
//  Copyright (c) 2015年 奥山博史. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIWebViewDelegate,UITextFieldDelegate{

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var forwardButton: UIBarButtonItem!

    @IBOutlet weak var activityIndicater: UIActivityIndicatorView!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
//ボーダー作成
        let topBorder = CALayer()
        topBorder.frame = CGRectMake(0, 0, self.webView.frame.size.width, 1)
        topBorder.backgroundColor = UIColor.lightGrayColor().CGColor
        self.webView.layer.addSublayer(topBorder)
        
        
        self.textField.delegate = self
        self.webView.delegate = self
        let startUrl = "http://dotinstall.com"
//        if let url = NSURL(string: startUrl){
//            let urlRequest = NSURLRequest(URL:url)
//            self.webView.loadRequest(urlRequest)
//        }else{
//            self.showAlert("invalid URL")
//        }
    self.jumpToUrl(startUrl)
        // Do any additional setup after loading the view, typically from a nib.
    setupButtonsEnabled()
        self.activityIndicater.hidesWhenStopped = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func jumpToUrl(urlString: String){
        if let url = NSURL(string: urlString){
            let urlRequest = NSURLRequest(URL:url)
            self.webView.loadRequest(urlRequest)
        }else{
            self.showAlert("invalid URL")
        }
    }
    func showAlert(message:String){
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //ネットワークエラー処理
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        self.webView.stopLoading()
        self.activityIndicater.stopAnimating()
        self.updateUrlLocation()
        if error.code != NSURLErrorCancelled{
            self.showAlert("Network Error")
        }
        self.updateUrlLocation()
    }
    func updateUrlLocation(){
        if let urlString  = self.webView.request?.URL.absoluteString{
            self.textField.text = urlString
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        var urlString = self.textField.text
        urlString = urlString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if urlString == "" {
            self.showAlert("Please enter URL")
        }else{
            if !urlString.hasPrefix("http://") && !urlString.hasPrefix("https://"){
                urlString = "http://" + urlString
            }
            
            self.jumpToUrl(urlString)
            self.setupButtonsEnabled()
        }
        self.textField.resignFirstResponder()
        return true
    }
    
    func setupButtonsEnabled(){
        self.backButton.enabled = self.webView.canGoBack
        self.forwardButton.enabled = self.webView.canGoForward
    }
    func webViewDidStartLoad(webView: UIWebView) {
        self.activityIndicater.startAnimating()
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        setupButtonsEnabled()
        self.activityIndicater.stopAnimating()
        self.updateUrlLocation()
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

