//
//  WebViewVM.swift
//  mobile_browser
//
//  Created by Charles on 8/4/22.
//

import Foundation
import WebKit

class WebViewVM: ObservableObject {
    let webView: WKWebView
    // Set defalut url as Google.com
    let url: URL = URL(string: "https://www.google.com")!
    
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var urlString: String = ""
    
    
    init() {
        webView = WKWebView(frame: .zero)
        
        webView.load(URLRequest(url: url))
        
        setUpBindings()
    }
    
    func loadURL() {
        guard let url = URL(string: urlString) else {
            return
        }
        
        webView.load(URLRequest(url: url))
    }
    
    private func setUpBindings() {
        webView
            .publisher(for: \.canGoBack)
            .assign(to: &$canGoBack)
        
        webView
            .publisher(for: \.canGoForward)
            .assign(to: &$canGoForward)
    }
    
    func goForward() {
        webView.goForward()
    }
    
    func goBack() {
        webView.goBack()
    }
}
