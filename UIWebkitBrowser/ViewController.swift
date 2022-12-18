//
//  ViewController.swift
//  UIWebkitBrowser
//
//  Created by maxshikin on 13.11.2022.
//



// Тест UIWebView

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var webView = WKWebView()
    
    let toolBar = UIToolbar()
    
    let backButtonImage = UIBarButtonItem(systemItem: .rewind)
    let forwardButtonImage = UIBarButtonItem(systemItem: .fastForward)
    let spacer = UIBarButtonItem(systemItem: .flexibleSpace)
    let refreshButtonImage = UIBarButtonItem(systemItem: .refresh)
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(toolBar)
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        toolBar.items = [backButtonImage, forwardButtonImage, spacer, refreshButtonImage]
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            toolBar.topAnchor.constraint(equalTo: webView.bottomAnchor),
            toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        backButtonImage.action = #selector(backAction)
        forwardButtonImage.action = #selector(forwardAction)
        refreshButtonImage.action = #selector(refreshAction)
        
        
        loadRequest ()
        
        webView.navigationDelegate = self
    }
    private func loadRequest () {
        guard let url = URL(string: "https://www.google.com") else {return}
        
        let urlReqest = URLRequest(url: url)
        webView.load(urlReqest)
    }

    @objc func backAction() {
        guard webView.canGoBack else {return}
        webView.goBack()
    }
    
    @objc func forwardAction() {
        guard webView.canGoForward else {return}
        webView.goForward()
    }
    
    @objc func refreshAction() {
        webView.reload()
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("decidePolicyFor")
        decisionHandler(.allow)
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("didcomit")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish")
        
        
        backButtonImage.isEnabled = webView.canGoBack
        forwardButtonImage.isEnabled = webView.canGoForward
    }
    
    
}
