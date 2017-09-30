//
//  TRNStateController+Default.swift

import Foundation
import UIKit

extension StateController where Self: UIViewController, Self: LoadingHud {

    // Event handling
    func showErrorWithContent(_ error: Error) {
        fatalError("Implement showErrorWithContent")
    }

    // View handling
    func showOriginalView() {
        if let loadingView = self.loadingView as? UIView {
            self.view.sendSubview(toBack: loadingView)
            loadingView.isHidden = true
        }
        if let errorView = self.errorView as? UIView {
            self.view.sendSubview(toBack: errorView)
            errorView.isHidden = true
        }
        if let infoView = self.infoView as? UIView {
            self.view.sendSubview(toBack: infoView)
            infoView.isHidden = true
        }
    }

    // mark: Loading
    func showLoadingView(statefulViewModel: StatefulViewModel) {

        loadingView?.fill(statefulViewModel)

        guard let loadingView = self.loadingView  as? UIView else {
            return
        }
        self.view.bringSubview(toFront: loadingView)
        loadingView.isHidden = false
    }

    // mark: Error
    func showErrorView(statefulViewModel: StatefulViewModel) {

        errorView?.fill(statefulViewModel)

        guard let errorView = self.errorView  as? UIView else {
            return
        }
        self.view.bringSubview(toFront: errorView)
        errorView.isHidden = false
    }

    // mark: Info
    func showInfoView(statefulViewModel: StatefulViewModel) {

        infoView?.fill(statefulViewModel)

        guard let infoView = self.infoView  as? UIView else {
            return
        }

        self.view.bringSubview(toFront: infoView)
        infoView.isHidden = false
    }
}

