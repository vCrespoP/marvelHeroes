
import UIKit
import WebKit

import Log
import RxSwift
import RxCocoa

class WebViewViewController: BaseViewController {

    // MARK: - Properties
    var presenter: WebViewPresenter?

    var webView: WKWebView! // = WKWebView(frame: CGRect.zero)
    var refreshControl: UIRefreshControl?
    var aiLoader = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    // MARK: - Outlets

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Initialization
    override func translation() {
        self.title = ""

    }

    override func initUI() {
        super.initUI()

        self.webView = WKWebView()

        self.view.addSubview(self.webView)
        self.view.bringSubview(toFront: self.webView)
        self.webView.autoPinEdgesToSuperviewEdges()

        self.aiLoader.hidesWhenStopped = true
        self.webView.addSubview(self.aiLoader)
        self.aiLoader.autoCenterInSuperview()
        self.webView.bringSubview(toFront: self.aiLoader)

        // Set delegate to handle events
        self.webView.navigationDelegate = self

        self.initPullToRefresh()

        self.view.layoutIfNeeded()

        self.refresh(sender: self)
    }

    fileprivate func initPullToRefresh() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        if let refreshControl = self.refreshControl {
            self.webView.scrollView.addSubview(refreshControl)
        }
    }

}

// MARK: - Public methods
extension WebViewViewController {

    func load(source: UrlSourceType?) {
        guard let source = source else {
            Log.error("No source found")
            return
        }
        switch source {
        case .local(let file):
            self.loadLocal(localFile: file)
        case .remote(let url):
            self.loadRemote(url: url)
        }
    }

    func disablePinchToZoom() {
        self.webView.scrollView.delegate = self
    }

    @objc func refresh(sender: AnyObject) {
        self.load(source: self.presenter?.source)
    }
}

// MARK: - Web View Delegate

/**

 UIWebViewDelegate     - webView:shouldStartLoadWithRequest:navigationType:
 WKNavigationDelegate  - webView:didStartProvisionalNavigation:

 UIWebViewDelegate     - webViewDidStartLoad:
 WKNavigationDelegate  - webView:didCommitNavigation:

 UIWebViewDelegate     - webViewDidFinishLoad:
 WKNavigationDelegate  - webView:didFinishNavigation:

 UIWebViewDelegate     - webView:didFailLoadWithError:
 WKNavigationDelegate  - webView:didFailNavigation:withError:
 - webView:didFailProvisionalNavigation:withError:

 */
extension WebViewViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.aiLoader.startAnimating()
    }

    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        self.aiLoader.startAnimating()
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.aiLoader.startAnimating()
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.aiLoader.stopAnimating()
        self.refreshControl?.endRefreshing()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        guard let url = navigationAction.request.url, webView == self.webView else {
            decisionHandler(.allow)
            return
        }

        switch url.scheme {
            //        case .some("mailto"), .some("tel"):
            //            decisionHandler(.cancel)
            //            let app = UIApplication.shared
            //            app.openURL(url)

        default:
            decisionHandler(.allow)
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async {
            self.aiLoader.stopAnimating()
            Log.error(error)
        }
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        Log.error(error)
        let nsError = error as NSError
        switch nsError.code {
        default:
            break
        }
    }
}

// MARK: ScrollView Delegate
extension WebViewViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }

}

// MARK: - Private methods
extension WebViewViewController {

    fileprivate func loadLocal(localFile: String) {
        let urlBase = URL(fileURLWithPath: Bundle.main.resourcePath!, isDirectory: true)
            .appendingPathComponent("API")

        let fileUrl = (urlBase.absoluteString + localFile)

        webView.loadFileURL(URL(string: fileUrl)!, allowingReadAccessTo: urlBase)
    }

    fileprivate func loadRemote(url: URL) {
        let request = URLRequest(url: url)
        _ = self.webView.load(request)

    }

}

