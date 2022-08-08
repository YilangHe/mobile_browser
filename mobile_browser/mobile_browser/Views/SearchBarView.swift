//
//  SearchBarView.swift
//  mobile_browser
//
//  Created by Charles on 8/4/22.
//

import SwiftUI
import WebKit

struct SearchBarView: View {
    @EnvironmentObject var webViewVM: WebViewVM
    @EnvironmentObject var tabsStore: TabsStore
    
    var body: some View {
        HStack {
            
            Button {
                webViewVM.reload()
            } label: {
                Image(systemName: "arrow.clockwise")
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.leading, 25)
            }
            .padding(.trailing, 17)
            .padding(.vertical, 8)
            
            HStack {
                TextField("Search or type URL ",
                          text: $webViewVM.urlString)
                .keyboardType(.URL)
                .autocapitalization(.none)
                .foregroundColor(Color.defaultPalette.light)
                .padding(.vertical, 8)
                .padding(.horizontal, 15)
            }
            .background(Color.defaultPalette.searchBar)
            .cornerRadius(30)
            .overlay(alignment: .trailing) {
                Button {
                    webViewVM.urlString = ""
                } label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 3)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            
            Button {
                let newWeb = WebSite(urlString: webViewVM.urlString)
                
                TabsStore.tabs.append(newWeb)
                
                webViewVM.loadURL()
            } label: {
                Text("GO")
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 15)
            }
            .background(Color.defaultPalette.medDark)
            .cornerRadius(15)
            .padding(.trailing, 17)
            .padding(.vertical, 8)
            .disabled(webViewVM.urlString.isEmpty)
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
