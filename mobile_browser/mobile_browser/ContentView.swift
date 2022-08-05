//
//  ContentView.swift
//  mobile_browser
//
//  Created by Charles on 8/4/22.
//

import SwiftUI

struct ContentView: View {
    init() {
        UIToolbar.appearance().barTintColor = UIColor(Color.defaultPalette.dark)
       }
    
    @StateObject var webViewVM = WebViewVM()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                // Background
                Color
                    .defaultPalette.dark
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    SearchBarView()
                    
                    WebView(webView: webViewVM.webView, url: webViewVM.url)
                    
                    Spacer()
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                ToolBarBtnGroup(webViewVM: webViewVM)
                
                Spacer()
            }
        }
        .environmentObject(webViewVM)
    }
}

@ViewBuilder
func ToolBarBtnGroup(webViewVM: WebViewVM) -> some View {
    Button {
        webViewVM.goBack()
    } label: {
        Image(systemName: "arrow.backward")
            .foregroundColor(webViewVM.canGoBack ? Color.white : Color.gray)
    }
    .disabled(!webViewVM.canGoBack)
    .padding(.horizontal, 10)
    
    Button {
        webViewVM.goForward()
    } label: {
        Image(systemName: "arrow.forward")
            .foregroundColor(webViewVM.canGoForward ? Color.white : Color.gray)
    }
    .disabled(!webViewVM.canGoForward)
    .padding(.horizontal, 10)
    
    Button {
        
    } label: {
        Image(systemName: "square.3.stack.3d")
            .foregroundColor(Color.white)
    }
    .padding(.horizontal, 10)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
