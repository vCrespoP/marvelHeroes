//
//  LoginViewModel.swift

import Foundation

import Domain

import RxSwift
import RxCocoa

final class WebViewPresenter {

    // MARK: - Properties
    fileprivate let navigator: WebViewNavigator
    weak fileprivate var view: WebViewViewController?
    fileprivate let disposeBag = DisposeBag()

    var source: UrlSourceType? {
        didSet {
            self.view?.load(source: source)
        }
    }

    // MARK: - Life Cycle
    init(navigator: WebViewNavigator, view: WebViewViewController, source: UrlSourceType) {
        self.navigator = navigator
        self.view = view
        self.source = source

        self.handleLifeCycle()
    }

    fileprivate func handleLifeCycle() {

        //        self.view?
        //            .rx
        //            .viewDidLoad.subscribe(onNext: { [weak self] in
        //                self?.view?.load(source: self?.source)
        //            })
        //            .addDisposableTo(self.disposeBag)
        //
        //        self.view?
        //            .rx
        //            .viewWillAppear
        //            .subscribe(onNext: { animated in
        //                Log.debug("Presenter: View Will Appear (animated: \(animated))")
        //            })
        //            .addDisposableTo(self.disposeBag)
        //
        //        self.view?
        //            .rx
        //            .viewDidAppear
        //            .subscribe(onNext: { animated in
        //                Log.debug("Presenter: View Did Appear (animated: \(animated))")
        //            })
        //            .addDisposableTo(self.disposeBag)

    }

}

// MARK: - Public Methods
extension WebViewPresenter {

}

// MARK: - Private Methods
extension WebViewPresenter {

}
