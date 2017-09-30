//
//  HeroesTableView.swift

import Foundation
import UIKit

import Domain

class HeroesTableView: UITableView {

    // MARK: Properties
    var dataSourceItems: Heroes? {
        didSet {
            self.reloadDataAnimated()
        }
    }

    weak var heroesDelegate: HeroesDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.registerCellNib(ofType: HeroTableViewCell.self)

        self.rowHeight = 200
        //        self.rowHeight = UITableViewAutomaticDimension
        //        self.estimatedRowHeight = 50

        self.delegate = self
        self.dataSource = self

        self.separatorStyle = .none
    }

}

// MARK: Private methods
extension HeroesTableView {

    fileprivate func hero(from dataSourceItems: Heroes?, at indexPath: IndexPath) -> Hero? {
        guard indexPath.row < dataSourceItems?.list?.count ?? 0 else {
            Log.error("Index for hero beyond bounds")
            return nil
        }
        return dataSourceItems?.list?[indexPath.row]
    }

}

extension HeroesTableView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let hero = self.hero(from: self.dataSourceItems, at: indexPath) else {
            Log.error("No hero found at indexPath")
            return
        }
        self.heroesDelegate?.heroSelected(hero: hero)
    }

}

extension HeroesTableView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceItems?.list?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = hero(from: self.dataSourceItems, at: indexPath)
        let cell = tableView.dequeueReusableCell(ofType: HeroTableViewCell.self, at: indexPath)
        cell.fill(with: item)
        return cell
    }

    // Remove separators on empty items
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

}
