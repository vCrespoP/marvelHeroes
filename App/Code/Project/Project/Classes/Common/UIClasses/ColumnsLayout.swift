//
//  ColumnsLayout.swift

import Foundation

import Foundation
import UIKit

/*
 How to use it:
 ```
 class CollectionViewController: UICollectionViewController {

 let columnLayout = ColumnFlowLayout(
 cellsPerRow: 5,
 minimumInteritemSpacing: 10,
 minimumLineSpacing: 10,
 sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
 )

 override func viewDidLoad() {
 super.viewDidLoad()

 collectionView?.collectionViewLayout = columnLayout
 }

 override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 return _count_
 }

 override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 return collectionView.dequeueReusableCell(withReuseIdentifier: "_cellIdentifier_", for: indexPath)
 }

 }
 ```
 */
class ColumnFlowLayout: UICollectionViewFlowLayout {

    // MARK: - Properties
    let cellsPerRow: Int
    override var itemSize: CGSize {
        get {
            guard let collectionView = collectionView else {
                return super.itemSize
            }
            let marginsAndInsets = sectionInset.left + sectionInset.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
            let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
            return CGSize(width: itemWidth, height: itemWidth)
        }
        set {
            super.itemSize = newValue
        }
    }

    // MARK: - Life Cycle
    init(cellsPerRow: Int, minimumInteritemSpacing: CGFloat = 0, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
        self.cellsPerRow = cellsPerRow
        super.init()

        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
        self.sectionInset = sectionInset
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - UICollectionViewFlowLayout

extension ColumnFlowLayout {

    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds != collectionView?.bounds
        return context
    }

}

