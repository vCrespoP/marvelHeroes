//
//  LoginNavigator.swift

import Foundation

import UIKit
import Domain

// MARK: - Protocol
protocol HeroDetailsNavigator {
    func toHeroDetails(hero: Hero)
}

// MARK: - Default
class DefaultHeroDetailsNavigator: HeroDetailsNavigator {

    private let storyboard: UIStoryboard
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController, storyboard: UIStoryboard) {
        self.navigationController = navigationController
        self.storyboard = storyboard
    }

    func toHeroDetails(hero: Hero) {
        let vc = storyboard.instantiateViewController(ofType: HeroDetailsViewController.self)
        vc.presenter = HeroDetailsPresenter(navigator: self, view: vc, source: hero)
        navigationController.pushViewController(vc, animated: true)
    }

}
