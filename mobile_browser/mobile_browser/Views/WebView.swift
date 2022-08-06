//
//  WebView.swift
//  mobile_browser
//
//  Created by Charles on 8/4/22.
//

import Foundation
import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    let webView : WKWebView
    @Binding var url : URL?
    
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(onUrlChange: { newURL in
            self.url = newURL
        })
        webView.navigationDelegate = coordinator
        return coordinator
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let action: (URL?) -> Void
        
        init(onUrlChange action: @escaping (URL?) -> Void) {
            self.action = action
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            action(webView.url)
        }
    }
}
