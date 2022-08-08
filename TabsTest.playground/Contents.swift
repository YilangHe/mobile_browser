import Foundation
import SwiftUI

class NavigationState : NSObject, ObservableObject {
    @Published var currentURL : URL?
    @Published var webViews : [WKWebView] = []
    @Published var selectedWebView : WKWebView?
    
    @discardableResult func createNewWebView(withRequest request: URLRequest) -> WKWebView {
        let wv = WKWebView()
        wv.navigationDelegate = self
        webViews.append(wv)
        selectedWebView = wv
        wv.load(request)
        return wv
    }
}

extension NavigationState : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if webView == selectedWebView {
            self.currentURL = webView.url
        }
    }
}

struct WebView : UIViewRepresentable {
    
    @ObservedObject var navigationState : NavigationState
    
    func makeUIView(context: Context) -> UIView  {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let webView = navigationState.selectedWebView else {
            return
        }
        if webView != uiView.subviews.first {
            uiView.subviews.forEach { $0.removeFromSuperview() }
            
            webView.frame = CGRect(origin: .zero, size: uiView.bounds.size)
            uiView.addSubview(webView)
        }
    }
}

struct ContentView: View {
    @StateObject var navigationState = NavigationState()
    
    var body: some View {
        VStack(){
            Button("create new tab"){
                navigationState.createNewWebView(withRequest: URLRequest(url: URL(string: "https://www.google.com")!))
            }
            Text(navigationState.currentURL?.absoluteString ?? "(none)")
            WebView(navigationState: navigationState)
                .clipped()
            HStack {
                Button("Back") {
                    navigationState.selectedWebView?.goBack()
                }
                Button("Forward") {
                    navigationState.selectedWebView?.goForward()
                }
            }
            
            List {
                ForEach(navigationState.webViews, id: \.self) { tab in
                    Button(action: {
                        navigationState.selectedWebView = tab
                    }) {
                        Text(tab.url?.absoluteString ?? "?")
                    }
                }
            }
        }
        
    }
}



