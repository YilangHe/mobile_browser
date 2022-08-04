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
    let url: URL
    
    init() {
        webView = WKWebView(frame: .zero)
        url = URL(string: "https://www.google.com")!
        
        loadURL()
    }
    
    func loadURL() {
        webView.load(URLRequest(url: url))
    }
}
