//
//  UICollectionView+Animation.swift

import Foundation
import UIKit

extension UICollectionView {

    func reloadDataAnimated() {
        DispatchQueue.main.async {
            UIView.transition(with: self,
                              duration: 0.35,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.reloadData()
            })
        }
    }

}
