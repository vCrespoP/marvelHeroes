//
//  LoginViewModel.swift

import Foundation

import Domain

import RxSwift
import RxCocoa

final class HeroDetailsPresenter: BasePresenter {

    // MARK: - Properties
    fileprivate let navigator: HeroDetailsNavigator
    weak fileprivate var view: HeroDetailsViewController?
    var hero: Hero?

    // MARK: - Life Cycle
    init(navigator: HeroDetailsNavigator, view: HeroDetailsViewController, source: Hero) {
        self.navigator = navigator
        self.view = view
        self.hero = source

        super.init()

        self.handleLifeCycle()
    }

    fileprivate func handleLifeCycle() {

        self.view?
            .rx
            .viewDidLoad.subscribe(onNext: { [weak self] in
                self?.view?.load(hero: self?.hero)
            })
            .addDisposableTo(self.disposeBag)

        self.view?
            .rx
            .viewWillAppear
            .subscribe(onNext: { animated in
                Log.debug("Presenter: View Will Appear (animated: \(animated))")
            })
            .addDisposableTo(self.disposeBag)

        self.view?
            .rx
            .viewDidAppear
            .subscribe(onNext: { animated in
                Log.debug("Presenter: View Did Appear (animated: \(animated))")
            })
            .addDisposableTo(self.disposeBag)

    }

}

// MARK: - Public Methods
extension HeroDetailsPresenter {

}

// MARK: - Private Methods
extension HeroDetailsPresenter {

}
