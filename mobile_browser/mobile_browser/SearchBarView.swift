//
//  SearchBarView.swift
//  mobile_browser
//
//  Created by 何逸朗 on 8/4/22.
//

import SwiftUI
import WebKit

struct SearchBarView: View {
    @EnvironmentObject var webViewVM: WebViewVM
    var body: some View {
        HStack {
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
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            
            Button {
                webViewVM.loadURL()
            } label: {
                Text("GO")
                    .foregroundColor(.gray)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 15)
            }
            .background(Color.defaultPalette.medDark)
            .cornerRadius(15)
            .padding(.trailing, 17)
            .padding(.vertical, 8)
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
