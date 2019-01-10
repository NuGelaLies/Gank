//
//  BaseWebViewController.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/3/7.
//

import UIKit
import WebKit

class BaseWebViewController: UBaseViewController {

    lazy var mainWebView: WKWebView = {
        let config = WKWebViewConfiguration()
        let web = WKWebView.init(frame: view.bounds, configuration: config)
        web.navigationDelegate = self
        web.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        web.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        return web
    }()
    
    lazy var progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.frame = CGRect(x: 0, y: 64, width: Constant.UI.kScreenW, height: 5)
        progress.progressTintColor = Theme.Color.theme
        progress.trackTintColor = .clear
        return progress
    }()
    
    var url: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let request = URLRequest.init(url: URL.init(string: url)!)
        mainWebView.load(request)
        
        
        
        
    }
    override func setupSubViews() {
        view.addSubview(mainWebView)
        view.addSubview(progressView)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            if let web = object as? WKWebView , web == mainWebView {
                title = web.title
            } else {
                title = "加载中"
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
        } else if keyPath == "estimatedProgress" {
            if let web = object as? WKWebView , web == mainWebView {
                self.progressView.alpha = 1.0
                self.progressView.setProgress(Float(web.estimatedProgress), animated: true)
                if web.estimatedProgress >= 1.0 {
                    self.progressView.fadeOut()
                    self.progressView.setProgress(0, animated: false)
                }
            } else {
                title = "加载中"
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
        } else {
            title = "加载中"
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    deinit {
        mainWebView.removeObserver(self, forKeyPath: "title")
        mainWebView.removeObserver(self, forKeyPath: "estimatedProgress")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension BaseWebViewController: WKNavigationDelegate {
    
}
