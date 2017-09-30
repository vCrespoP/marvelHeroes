//
//  UIScrollView+Scroll.swift

import Foundation
import UIKit

extension UITableView {

    func scrollToTop(animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: animated)
        }
    }

}

extension UICollectionView {

    func scrollToTop(animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToItem(at: indexPath, at: .top, animated: animated)
        }
    }

}

