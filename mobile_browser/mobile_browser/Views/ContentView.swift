//
//  ContentView.swift
//  mobile_browser
//
//  Created by Charles on 8/4/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var savedTabStore: SavedTabStore
    @EnvironmentObject var webViewVM: WebViewVM    
    @Environment(\.scenePhase) private var scenePhase
    
    
    var body: some View {
        switch webViewVM.currentScreen {
        case .homeview:
            HomeView()
        case .saved:
            SavedTabsList()
        case .tabs:
            SavedTabsList()
        }
    }
}





// Components

struct HomeView: View {
    init() {
        UIToolbar.appearance().barTintColor = UIColor(Color.defaultPalette.dark)
    }
    
    @EnvironmentObject var savedTabStore: SavedTabStore
    @EnvironmentObject var webViewVM: WebViewVM
    
    var body: some View {
        NavigationView {
            VStack {
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
                        ToolBarBtnGroup()
                        
                        Spacer()
                    }
                }
            }
            .environmentObject(webViewVM)
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct ToolBarBtnGroup: View {
    @EnvironmentObject var webViewVM: WebViewVM
    @EnvironmentObject var savedTabStore: SavedTabStore
    
    var body: some View {
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
            let newWebsite = WebSite(urlString: webViewVM.urlString)
            savedTabStore.savedTabs.append(newWebsite)
        } label: {
            Image(systemName: "star")
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
            Button {
                webViewVM.switchToSaved()
            } label: {
                Image(systemName: "bookmark")
                    .foregroundColor(Color.white)
            }
        }
        .padding(.horizontal, 10)
        
        Spacer()
    }
}



//Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
