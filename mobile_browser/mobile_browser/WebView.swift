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
    var url : URL
    
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        webView.load(URLRequest(url: url))
    }
}
