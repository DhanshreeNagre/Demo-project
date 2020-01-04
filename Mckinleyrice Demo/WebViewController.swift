import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let token: String = UserDefaults.standard.string(forKey: "token") {
            if let url = URL(string: "https://www.mckinleyrice.com/?token=\(token)") {
                let request = URLRequest(url: url)
                    webView.load(request)
            }
        }
    }

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    @objc func buttonClicked(sender : UIButton){
          UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
          UserDefaults.standard.set(nil, forKey: "token")
          UserDefaults.standard.synchronize()
      }
}
