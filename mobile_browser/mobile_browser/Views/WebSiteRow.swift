//
//  WebSiteRow.swift
//  mobile_browser
//
//  Created by Charles on 8/5/22.
//

import SwiftUI

struct WebSiteRow: View {
    @EnvironmentObject var webViewVM: WebViewVM
    var website: WebSite
    
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                Text(extractWebSiteName().capitalized)
                    .bold()
                    .font(.system(size: 25))
                Text(website.urlString)
                    .lineLimit(2)
            }
            .padding(.leading, 5)
            .padding(.vertical, 5)
            Spacer()
        }.onTapGesture {
            webViewVM.switchToHome()
            webViewVM.urlString = website.urlString
            webViewVM.loadURL()
        }
    }
    
    func extractWebSiteName() -> String {
        let components = self.website.urlString.components(separatedBy: ".")
        return components[1]
    }
}



struct WebSiteRow_Previews: PreviewProvider {
    static var previews: some View {
        let testWeb = WebSite(urlString: "https://www.google.com")
        WebSiteRow(website: testWeb)
    }
}
