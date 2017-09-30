//
//  UIWindow+Replace.swift

import Foundation
import UIKit

extension UIWindow {

    func replaceAnimated(navigationController: UINavigationController) {
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.rootViewController = navigationController
        }, completion: { _ in
            print("Log in completed")
        })
    }

}

