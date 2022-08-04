//
//  ContentView.swift
//  mobile_browser
//
//  Created by Charles on 8/4/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var webViewVM = WebViewVM()
    var body: some View {
        WebView(webView: webViewVM.webView, url: webViewVM.url)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
