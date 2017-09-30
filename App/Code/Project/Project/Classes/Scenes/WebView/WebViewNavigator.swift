//
//  LoginNavigator.swift

import Foundation

import UIKit
import Domain

// MARK: - Protocol
protocol WebViewNavigator {
    func toWebView(source: UrlSourceType)
}

enum UrlSourceType {
    case local(file: String)
    case remote(url: URL)
}

// MARK: - Default
class DefaultWebViewNavigator: WebViewNavigator {

    private let storyboard: UIStoryboard
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController, storyboard: UIStoryboard) {
        self.navigationController = navigationController
        self.storyboard = storyboard
    }

    func toWebView(source: UrlSourceType) {
        let vc = storyboard.instantiateViewController(ofType: WebViewViewController.self)
        vc.presenter = WebViewPresenter(navigator: self, view: vc, source: source)
        navigationController.pushViewController(vc, animated: true)
    }

}
