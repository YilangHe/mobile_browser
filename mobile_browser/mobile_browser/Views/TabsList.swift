//
//  TabsView.swift
//  mobile_browser
//
//  Created by Charles on 8/5/22.
//

import SwiftUI

import SwiftUI

struct TabsList: View {
    @EnvironmentObject var tabsStore: TabsStore
    @EnvironmentObject var webViewVM: WebViewVM
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    webViewVM.switchToHome()
                } label: {
                    Image(systemName: "arrow.left")
                }
                .padding()
                
                Spacer()
            }
            NavigationView {
                VStack {
                    List {
                        ForEach(TabsStore.tabs, id: \.id) { tab in
                            WebSiteRow(website: tab)
                        }
                        .onDelete(perform: delete)
                    }
                }
                .navigationBarTitle("Tabs")
                
            }
            .navigationViewStyle(.stack)
            .navigationBarBackButtonHidden(true)
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        TabsStore.tabs.remove(atOffsets: offsets)
        webViewVM.urlString = ""
    }
}

//struct TabsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabsList()
//    }
//}
