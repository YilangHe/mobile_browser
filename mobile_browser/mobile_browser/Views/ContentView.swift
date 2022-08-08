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
    
    let saveAction: ()->Void
    
    
    var body: some View {
        switch webViewVM.currentScreen {
        case .homeview:
            HomeView()
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive { saveAction() }
                }
        case .saved:
            SavedTabsList()
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive { saveAction() }
                }
        case .tabs:
            TabsList()
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive { saveAction() }
                }
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
    @State var isCurrWebSaved: Bool = false
    
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
            if !isSaved() {
                let newWebsite = WebSite(urlString: webViewVM.urlString)
                savedTabStore.savedTabs.append(newWebsite)
                isCurrWebSaved = true
            } else {
                removeSaved()
                isCurrWebSaved = false
            }
            
        } label: {
            Image(systemName: isSaved() ? "star.fill" : "star")
                .foregroundColor(Color.white)
        }
        .padding(.horizontal, 10)
        
        
        Spacer()
        
        Button {
            
        } label: {
            Button {
                webViewVM.switchToTabs()
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
    
    func isSaved() -> Bool {
        for website in savedTabStore.savedTabs {
            if webViewVM.urlString.lowercased() == website.urlString.lowercased() {
                return true
            }
        }
        return false
    }
    
    func removeSaved() {
        let size = savedTabStore.savedTabs.count
        for i in 0..<size {
            if savedTabStore.savedTabs[i].urlString.lowercased() == webViewVM.urlString.lowercased() {
                savedTabStore.savedTabs.remove(at: i)
                break
            }
        }
    }
}



//Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(saveAction: {})
    }
}
