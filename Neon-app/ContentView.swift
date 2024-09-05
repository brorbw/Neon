import SwiftUI
import WebKit


struct ContentView: View {
    @State private var showModal = false
    @State private var urlString = "https://plex.tv"
    @State private var webView = WebView()
    var body: some View {
        if showModal {
            ModalView(showModal: $showModal, urlString: $urlString, webView: $webView)
        } else {
            webView
              .toolbar {
                  ToolbarItem(placement: .primaryAction) {
                      Menu {
                          Button(action: {self.showModal.toggle()}) {
                              Label("Open URL", systemImage: "doc")
                          }

                      }
                      label: {
                          Label("Add", systemImage: "plus")
                      }
                  }
              }
        }
    }
}

struct ModalView: View {
    @Binding var showModal: Bool
    @Binding var urlString: String
    @Binding var webView: WebView
    var body: some View {
        ZStack {
            Rectangle()
              .fill(Color.gray.opacity(0.1))
            VStack {
                Text("Open site")
                  .font(.title).foregroundColor(.white)

                Divider()

                TextField("Enter text", text: $urlString)
                  .textCase(.uppercase)
                  .padding(5)
                  .background(Color.gray.opacity(0.2))
                  .foregroundColor(.white)
                  .padding(.horizontal, 20)

                Divider()

                HStack {
                    Button("Open") {
                        self.showModal.toggle()
                        webView.webURL = URL(string: urlString)!
                        webView.loadNewURL()
                    }
                }
            }
        }
    }
}

#Preview{
    ContentView()
}


struct WebView: NSViewRepresentable {
    var webURL = URL(string: "https://plex.tv")!
    var webView: WKWebView!

    init() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView (frame: .zero, configuration:webConfiguration)
    }

    func makeNSView(context: Context) -> WKWebView {
        return webView
    }

    func updateNSView(_ uiView: WKWebView, context: Context) {
        webView.load(URLRequest(url: webURL))
    }

    func loadNewURL(){
        webView.load(URLRequest(url: webURL))
    }
}
