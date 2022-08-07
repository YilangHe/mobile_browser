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
    let defaultUrl: URL = URL(string: "https://www.google.com")!
    
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var urlString: String = ""
    
    @Published var displayingURL: URL? {
        didSet {
            urlString = displayingURL?.absoluteString ?? ""
            print("New url is: \(String(describing: displayingURL))")
        }
    }
    
    @Published var openedTabs: [WebSite] = []
    @EnvironmentObject var savedTabStore: SavedTabStore
    
    enum Screen {
        case homeview
        case saved
        case tabs
    }
    
    @Published private(set) var currentScreen: Screen
    
    init() {
        webView = WKWebView(frame: .zero)
        
        currentScreen = .homeview
        
        webView.load(URLRequest(url: defaultUrl))
        
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
    
    func reload() {
        webView.reload()
    }
    
    
//
//    func removeFromSaved() {
//        if let index = savedTabs.firstIndex(of: WebSite(urlString: urlString)) {
//            savedTabs.remove(at: index)
//        }
//    }
    
    func verifyUrl () -> Bool {
        if let url = NSURL(string: urlString) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
    
    func switchToHome() -> Void {
        if currentScreen == .homeview {
            return
        }
        else {
            currentScreen = .homeview
        }
    }
    
    func switchToSaved() -> Void {
        if currentScreen == .saved {
            return
        }
        else {
            currentScreen = .saved
        }
    }
}
