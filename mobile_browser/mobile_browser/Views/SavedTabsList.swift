//
//  SavedTabsList.swift
//  mobile_browser
//
//  Created by Charles on 8/5/22.
//

import SwiftUI

struct SavedTabsList: View {
    @EnvironmentObject var savedTabStore: SavedTabStore
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
                        ForEach(savedTabStore.savedTabs, id: \.id) { tab in
                            WebSiteRow(website: tab)
                        }
                        .onDelete(perform: delete)
                    }
                }
                .navigationBarTitle("Saved")
                
            }
            .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        savedTabStore.savedTabs.remove(atOffsets: offsets)
    }
}

//struct SavedTabsList_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedTabsList(savedTabs: test)
//    }
//}
