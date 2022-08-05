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
        ZStack(alignment: .bottom) {
            // Background
            Color
                .defaultPalette.dark
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    HStack {
                        TextField("Search or type URL ",
                                  text: $webViewVM.urlString)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                        .foregroundColor(Color.defaultPalette.light)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 15)
                    }
                    .background(Color.defaultPalette.searchBar)
                    .cornerRadius(30)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    
                    Button {
                        webViewVM.loadURL()
                    } label: {
                        Text("GO")
                            .foregroundColor(.gray)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 15)
                    }
                    .background(Color.defaultPalette.medDark)
                    .cornerRadius(15)
                    .padding(.trailing, 17)
                    .padding(.vertical, 8)
                }
                WebView(webView: webViewVM.webView, url: webViewVM.url)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
