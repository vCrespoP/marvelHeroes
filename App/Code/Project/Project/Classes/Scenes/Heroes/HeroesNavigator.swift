//
//  LoginNavigator.swift

import Foundation

import UIKit
import Domain

// MARK: - Protocol
protocol HeroesNavigator {
    func toHeroes()

    func toAbout()
    func toHeroDetails(hero: Hero)
}

// MARK: - Default
class DefaultHeroesNavigator {

    // MARK: - Properties
    fileprivate let storyboard: UIStoryboard
    fileprivate let navigationController: UINavigationController
    fileprivate let dataSourceProvider: UseCaseDataSourceProvider

    // MARK: - Life Cycle
    init(dataSourceProvider: UseCaseDataSourceProvider, navigationController: UINavigationController, storyboard: UIStoryboard) {
        self.storyboard = storyboard
        self.navigationController = navigationController
        self.dataSourceProvider = dataSourceProvider
    }

}

// MARK: - Methods
extension DefaultHeroesNavigator: HeroesNavigator {

    func toHeroes() {
        let vc = self.storyboard.instantiateViewController(ofType: HeroesViewController.self)
        vc.presenter = HeroesPresenter(
            dataSourceProvider: dataSourceProvider,
            navigator: self,
            view: vc)

        self.navigationController.setViewControllers([vc], animated: true)
        AppDelegate.shared.window?.replaceAnimated(navigationController: self.navigationController)
    }

    func toAbout() {
        let url = URL(string: "https://github.com/vCrespoP")!
        UIApplication.shared.open(url, options: [:], completionHandler: { _ in })
    }

    func toHeroDetails(hero: Hero) {
        let storyboard = UIStoryboard(name: HeroDetailsViewController.reuseId, bundle: nil)
        let navigator = DefaultHeroDetailsNavigator(navigationController: self.navigationController, storyboard: storyboard)
        navigator.toHeroDetails(hero: hero)
    }

}

