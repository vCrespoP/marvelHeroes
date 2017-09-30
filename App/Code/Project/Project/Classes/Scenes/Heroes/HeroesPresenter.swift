//
//  LoginViewModel.swift

import Foundation

import Domain

import RxSwift
import RxCocoa

final class HeroesPresenter: BasePresenter {

    // MARK: - Properties
    fileprivate let dataSourceProvider: UseCaseDataSourceProvider
    fileprivate let navigator: HeroesNavigator
    weak fileprivate var view: HeroesViewController?

    var dataSource: Heroes? {
        didSet {
            self.dataSourceFiltered = dataSource
        }
    }
    var dataSourceFiltered: Heroes? {
        didSet {
            self.view?.reloadUI()
            self.processEmptyResults()
        }
    }

    // MARK: - Life Cycle
    init(dataSourceProvider: UseCaseDataSourceProvider, navigator: HeroesNavigator, view: HeroesViewController) {
        self.dataSourceProvider = dataSourceProvider
        self.navigator = navigator
        self.view = view

        super.init()

        self.handleLifeCycle()
    }

    fileprivate func handleLifeCycle() {

        self.view?
            .rx
            .viewDidLoad.subscribe(onNext: { [weak self] in
                Log.debug("Presenter: View Did Load")
                self?.getHeroes()
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
extension HeroesPresenter {

    func filterHeroes(query: String?) {
        // No query or it's empty
        guard let queryTrimmed = query?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) else {
            self.dataSourceFiltered = self.dataSource
            return
        }
        guard queryTrimmed.characters.count > 0 else {
            self.dataSourceFiltered = self.dataSource
            return
        }
        let filteredList = self.dataSource?.list?.filter({ hero in
            if compareContains(s1: hero.name, s2: query) {
                return true
            }
            // Could be a more general search
            //            if compareContains(s1: hero.abilities, s2: query) {
            //                return true
            //            }
            //            if compareContains(s1: hero.realName, s2: query) {
            //                return true
            //            }
            //            if compareContains(s1: hero.height, s2: query) {
            //                return true
            //            }
            //            if compareContains(s1: hero.power, s2: query) {
            //                return true
            //            }
            //            if compareContains(s1: hero.groups, s2: query) {
            //                return true
            //            }
            return false
        })
        self.dataSourceFiltered?.list = filteredList
    }

    func getHeroes() {

        self.view?.showLoadingDialog()

        self.dataSourceProvider
            .makeUseCaseGetHeroes()
            .getHeroes()
            .subscribe(
                onNext: { [weak self] response in
                    self?.dataSource = response.data
                }, onError: { [weak self] error in
                    self?.view?.show(error: error)
                }, onCompleted: {

            }, onDisposed: { [weak self] in
                self?.view?.hideLoadingDialog()
                self?.view?.tvHeroes.refreshControl?.endRefreshing()
                self?.view?.cvHeroes.refreshControl?.endRefreshing()
            })
            .addDisposableTo(self.disposeBag)
    }

    func toAbout() {
        self.navigator.toAbout()
    }

    func toHeroDetails(hero: Hero) {
        self.navigator.toHeroDetails(hero: hero)
    }

}

// MARK: - Private Methods
extension HeroesPresenter {

    fileprivate func processEmptyResults() {
        // No elements present ~> Show empty view
        if self.dataSourceFiltered?.list?.count == 0 {
            let emptyVM = StatefulViewModel(
                text: "No heroes found :(",
                handler: { [weak self] in
                    self?.getHeroes()
            })
            self.view?.showInfoView(statefulViewModel: emptyVM)
        } else {
            // Elements present ~> Show original view
            self.view?.showOriginalView()
        }
    }

    fileprivate func compareContains(s1: String?, s2: String?) -> Bool {
        guard let s1 = s1 else {
            return true
        }
        guard let s2 = s2 else {
            return true
        }
        let s1Processed = s1.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        let s2Processed = s2.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        return s1Processed.contains(s2Processed)
    }

}
