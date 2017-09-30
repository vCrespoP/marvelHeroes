//
//  HeroesTableView.swift

import Foundation
import UIKit

import Domain

class HeroCollectionView: UICollectionView {

    // MARK: - Properties
    var dataSourceItems: Heroes? {
        didSet {
            self.reloadDataAnimated()
        }
    }
    var columns: Int = 2 {
        didSet {
            self.configureLayout(columns: columns)
        }
    }

    weak var heroesDelegate: HeroesDelegate?

    // MARK: - IBOutlets

    // MARK: - Life Cycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.registerCells()

        self.dataSource = self
        self.delegate = self

        self.configureLayout(columns: self.columns)
    }
}

extension HeroCollectionView {

    fileprivate func registerCells() {
        self.registerCellNib(ofType: HeroCollectionViewCell.self)
    }

    fileprivate func configureLayout(columns: Int) {
        let columnLayout = ColumnFlowLayout(
            cellsPerRow: columns,
            minimumInteritemSpacing: 0,
            minimumLineSpacing: 0,
            sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        )
        self.setCollectionViewLayout(columnLayout, animated: true)
        if self.dataSourceItems?.list?.count ?? 0 > 0 {
            self.scrollToTop(animated: true)
        }

    }
}

// MARK: - Collection View Data Source
extension HeroCollectionView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSourceItems?.list?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(ofType: HeroCollectionViewCell.self, at: indexPath)

        let item = self.hero(from: self.dataSourceItems, at: indexPath)
        cell.fill(with: item)
        return cell
    }
}

// MARK: - Collection View Delegate
extension HeroCollectionView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let item = self.hero(from: self.dataSourceItems, at: indexPath) else {
            print("No item found")
            return
        }
        self.heroesDelegate?.heroSelected(hero: item)

    }

}

// MARK: - Private Methods
extension HeroCollectionView {

    fileprivate func hero(from dataSourceItems: Heroes?, at indexPath: IndexPath) -> Hero? {
        guard indexPath.row < dataSourceItems?.list?.count ?? 0 else {
            Log.error("Index for hero beyond bounds")
            return nil
        }
        return dataSourceItems?.list?[indexPath.item]
    }

}

