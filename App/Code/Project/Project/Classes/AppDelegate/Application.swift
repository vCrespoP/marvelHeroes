//
//  Application.swift

import Foundation
import UIKit

import Domain

import PlatformNetworkApi
import PlatformNetworkStatic

final class Application {
    static let shared = Application()

    let dataSourceProviderConfiguration: DataSourceConfiguration

    private init() {
        self.dataSourceProviderConfiguration =  DataSourceConfiguration()

        self.initKeyboardManager()
        self.initCrashlytics()
        self.initHUD()
        self.trackVersion()
        self.customizeAppearence()
    }

}

extension Application {

    func configureMainInterface(in window: UIWindow) {

        let storyboard = UIStoryboard(name: "HeroesViewController", bundle: nil)
        let navigationController = NavigationController()
        let navigator = DefaultHeroesNavigator(
            dataSourceProvider: dataSourceProviderConfiguration.getType(for: .getHeroes),
            navigationController: navigationController,
            storyboard: storyboard
        )

        window.rootViewController = navigationController

        navigator.toHeroes()

    }

}

import IQKeyboardManager
import PKHUD
import AppVersionMonitor

extension Application {

    fileprivate func initKeyboardManager() {
        IQKeyboardManager.shared().isEnabled = true
    }

    fileprivate func initCrashlytics() {
        //            Fabric.with( [ Crashlytics.self ] )
    }

    fileprivate func initHUD () {
        PKHUD.sharedHUD.dimsBackground = false
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
    }

}

extension Application {

    fileprivate func trackVersion() {
        AppVersionMonitor.sharedMonitor.startup()
    }

    fileprivate func customizeAppearence() {

        // Custom image for back

        //        let backArrowImage = UIImage(named: "BackArrow")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        //        UINavigationBar.appearance().backIndicatorImage = backArrowImage
        //        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backArrowImage

        // Customize navigation bar
        let fontColor  = ThemeColor.fontPrimaryLight
        let backgroundColor = ThemeColor.bgPrimaryDark

        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: fontColor
        ]

        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = fontColor
        UINavigationBar.appearance().barTintColor = backgroundColor
        UINavigationBar.appearance().backgroundImage(for: .default)

        // Custom appearence

        //        UISwitch.appearance().onTintColor = secondaryTextColor
        //        UIStepper.appearance().tintColor = secondaryTextColor

    }

}
