//
//  HeroeTableViewCell.swift

import Foundation
import UIKit

import Domain

class HeroCollectionViewCell: UICollectionViewCell {

    // MARK: Properties

    // MARK: IBOutlets

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()

        self.lbName.styleTitle2()
        self.backgroundColor = UIColor.clear
    }

}

// MARK: - Public Methods
extension HeroCollectionViewCell {

    func fill(with item: Hero?) {

        self.lbName.text = item?.name
        self.imgProfile.setImage(with: item?.photoUrl)
    }

}

