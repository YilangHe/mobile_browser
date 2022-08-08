//
//  mobile_browserApp.swift
//  mobile_browser
//
//  Created by Charles on 8/4/22.
//

import SwiftUI

@main
struct mobile_browserApp: App {
    @StateObject var webViewVM = WebViewVM()
    @StateObject var savedTabsStore = SavedTabStore()
    @StateObject var tabsStore = TabsStore()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView(){
                // save actions
                SavedTabStore.save(tabs: savedTabsStore.savedTabs) { result in
                    if case .failure(let error) = result {
                        fatalError(error.localizedDescription)
                    }
                }
                
                TabsStore.save(tabs: TabsStore.tabs) { result in
                    if case .failure(let error) = result {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .environmentObject(webViewVM)
            .environmentObject(savedTabsStore)
            .environmentObject(tabsStore)
            .onAppear {
                SavedTabStore.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let savedTabs):
                        savedTabsStore.savedTabs = savedTabs
                    }
                }
                
                TabsStore.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let tabs):
                        TabsStore.tabs = tabs
                    }
                }
            }
        }
    }
}
