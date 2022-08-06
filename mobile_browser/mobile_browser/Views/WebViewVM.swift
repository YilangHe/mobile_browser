//
//  WebViewVM.swift
//  mobile_browser
//
//  Created by Charles on 8/4/22.
//

import Foundation
import WebKit
import SwiftUI

class WebViewVM: ObservableObject {
    let webView: WKWebView
    // Set defalut url as Google.com
    let url: URL = URL(string: "https://www.google.com")!
    
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var urlString: String = ""
    
    @Published var openedTabs: [WebSite] = []
    @Published var savedTabs: [WebSite] = []
    
    
    init() {
        webView = WKWebView(frame: .zero)
        
//        webView.load(URLRequest(url: url))
        
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
    
    func isSaved() -> Bool {
        for website in savedTabs {
            if urlString.lowercased() == website.urlString.lowercased() {
                return true
            }
        }
        return false
    }
    
    func removeFromSaved() {
        if let index = savedTabs.firstIndex(of: WebSite(urlString: urlString)) {
            savedTabs.remove(at: index)
        }
    }
    
    func verifyUrl () -> Bool {
        if let url = NSURL(string: urlString) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
}
