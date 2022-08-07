//
//  SavedTabsList.swift
//  mobile_browser
//
//  Created by Charles on 8/5/22.
//

import SwiftUI

struct SavedTabsList: View {
    @EnvironmentObject var saveTabStore: SavedTabStore
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
                    List(saveTabStore.savedTabs, id: \.id) { tab in
                        WebSiteRow(website: tab)
                    }
                }
                .navigationBarTitle("Saved")
                
            }
            .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
        }
        
    }
}

//struct SavedTabsList_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedTabsList(savedTabs: test)
//    }
//}
