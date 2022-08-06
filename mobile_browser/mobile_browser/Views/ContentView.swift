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
                    
                    WebView(webView: webViewVM.webView, url: $webViewVM.displayingURL)
                    
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    ToolBarBtnGroup(webViewVM: webViewVM)
                    
                    Spacer()
                }
            }
            .environmentObject(webViewVM)
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}





// Components

@ViewBuilder
func ToolBarBtnGroup(webViewVM: WebViewVM) -> some View {
    Spacer()
    Group {
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
    }
    
    Spacer()
    
    Button {
        if !webViewVM.isSaved() && webViewVM.verifyUrl() {
            webViewVM.savedTabs.append(WebSite(urlString: webViewVM.urlString))
        } else {
            webViewVM.removeFromSaved()
        }
        
    } label: {
        Image(systemName: webViewVM.isSaved() ? "star.fill" : "star")
            .foregroundColor(Color.white)
    }
    .padding(.horizontal, 10)
    
    
    Spacer()
    
    Button {
        
    } label: {
        NavigationLink {
            TabsView()
        } label: {
            Image(systemName: "square.3.stack.3d")
                .foregroundColor(Color.white)
        }
    }
    .padding(.horizontal, 10)
    
    Spacer()
    
    Button {
        
    } label: {
        NavigationLink {
            SavedTabsList()
        } label: {
            Image(systemName: "bookmark")
                .foregroundColor(Color.white)
        }
    }
    .padding(.horizontal, 10)
    
    Spacer()
}


//Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
