//
//  BaseWebViewController.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/3/7.
//

import UIKit
import WebKit

class BaseWebViewController: BaseViewController {

    lazy var mainWebView: WKWebView = {
        let config = WKWebViewConfiguration()
        let web = WKWebView.init(frame: view.bounds, configuration: config)
        web.navigationDelegate = self
        web.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        return web
    }()
    
    var url: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let request = URLRequest.init(url: URL.init(string: url)!)
        mainWebView.load(request)
    }
    override func setupSubViews() {
        view.addSubview(mainWebView)
        
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            if let web = object as? WKWebView , web == mainWebView {
                title = web.title
            } else {
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    deinit {
        mainWebView.removeObserver(self, forKeyPath: "title")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension BaseWebViewController: WKNavigationDelegate {
    
}
