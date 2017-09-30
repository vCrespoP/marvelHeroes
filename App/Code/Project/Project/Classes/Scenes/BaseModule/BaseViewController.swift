
import UIKit
import Foundation

import Domain
import NetworkSpecific

import RxSwift
import PureLayout

class BaseViewController: UIViewController, ViewControllerMessages, LoadingHud, StateController {

    // Protocol properties
    var loadingView: StatefulViewProtocol?
    var errorView: StatefulViewProtocol?
    var infoView: StatefulViewProtocol?

    //
    // MARK: Properties
    //
    let disposeBag = DisposeBag()

    //
    // MARK: Outlets
    //

    //
    // MARK: Life Cycle
    //

    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()

        loadingView = ViewStatefulDefault.createView(in: self.view)
        errorView = ViewStatefulDefault.createView(in: self.view)
        infoView = ViewStatefulDefault.createView(in: self.view)

        self.showOriginalView()

        self.initViewController()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    //
    // MARK: Initialization
    //
    func initViewController() {
        self.translation()
        self.initUI()
    }

    func translation() {

    }

    func initUI() {
        self.view.backgroundColor = ThemeColor.bgPrimaryDark
        self.navigationController?.navigationBar.barStyle = .blackOpaque
    }

    func show(error: Error) {

        if let errorResponse = error as? ErrorResponse {
            let errorMessage = errorResponse.message?.text ?? "GLOBAL_GENERIC_ERROR_MESSAGE".localized
            self.showMessage(title: errorMessage, type: .error)
        }

        guard let projectError = error as? ProjectError else {
            Log.error("Not treating error: \(error)")
            return
        }

        switch projectError {
        default:
            self.showMessage(title: "GLOBAL_GENERIC_ERROR_MESSAGE".localized, type: .error)
        }

    }

}
