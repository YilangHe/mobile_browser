//
//  SavedTabsList.swift
//  mobile_browser
//
//  Created by Charles on 8/5/22.
//

import SwiftUI

struct SavedTabsList: View {
    @StateObject var webViewVM: WebViewVM = WebViewVM()
    
    var test = [WebSite(urlString: "https://www.google.com")]
    var body: some View {
        NavigationView {
            List(test, id: \.id) { tab in
                WebSiteRow(website: tab)
            }
            .navigationTitle("Saved")
        }
        
    }
}

struct SavedTabsList_Previews: PreviewProvider {
    static var previews: some View {
        SavedTabsList()
    }
}
