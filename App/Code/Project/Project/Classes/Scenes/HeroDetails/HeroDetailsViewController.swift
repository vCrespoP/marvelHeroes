
import UIKit

import Domain

import RxSwift
import RxCocoa

class HeroDetailsViewController: BaseViewController {

    // MARK: - Properties
    var presenter: HeroDetailsPresenter?

    // MARK: - Outlets
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var lbNameTitle: UILabel!
    @IBOutlet weak var lbNameText: UILabel!
    @IBOutlet weak var lbHeightTitle: UILabel!
    @IBOutlet weak var lbHeightText: UILabel!
    @IBOutlet weak var lbRealNameTitle: UILabel!
    @IBOutlet weak var lbRealNameText: UILabel!
    @IBOutlet weak var lbPowerTitle: UILabel!
    @IBOutlet weak var lbPowerText: UILabel!
    @IBOutlet weak var lbAbilitiesTitle: UILabel!
    @IBOutlet weak var lbAbilitiesText: UILabel!
    @IBOutlet weak var lbGroupsTitle: UILabel!
    @IBOutlet weak var lbGroupsText: UILabel!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Initialization
    override func translation() {
        self.title = ""

    }

    override func initUI() {
        super.initUI()

        self.lbNameTitle.styleTitle3()
        self.lbNameText.styleBody()
        self.lbHeightTitle.styleTitle3()
        self.lbHeightText.styleBody()
        self.lbRealNameTitle.styleTitle3()
        self.lbRealNameText.styleBody()
        self.lbPowerTitle.styleTitle3()
        self.lbPowerText.styleBody()
        self.lbAbilitiesTitle.styleTitle3()
        self.lbAbilitiesText.styleBody()
        self.lbGroupsTitle.styleTitle3()
        self.lbGroupsText.styleBody()

        self.imgBackground.addBlur(style: .dark)
    }

}

// MARK: - Public methods
extension HeroDetailsViewController {

    func load(hero: Hero?) {

        self.imgBackground.setImage(with: hero?.photoUrl)

        self.title = hero?.name

        self.lbNameTitle.text = "HERO_DETAILS_NAME_TITLE".localized
        self.lbNameText.text = hero?.name ?? "-"
        self.lbHeightTitle.text = "HERO_DETAILS_HEIGHT_TITLE".localized
        self.lbHeightText.text = hero?.height ?? "-"
        self.lbRealNameTitle.text = "HERO_DETAILS_REAL_NAME_TITLE".localized
        self.lbRealNameText.text = hero?.realName ?? "-"
        self.lbPowerTitle.text = "HERO_DETAILS_POWER_TITLE".localized
        self.lbPowerText.text = hero?.power ?? "-"
        self.lbAbilitiesTitle.text = "HERO_DETAILS_ABILITIES_TITLE".localized
        self.lbAbilitiesText.text = hero?.abilities ?? "-"
        self.lbGroupsTitle.text = "HERO_DETAILS_GROUPS_TITLE".localized
        self.lbGroupsText.text = hero?.groups ?? "-"
    }

}

// MARK: - Private methods
extension HeroDetailsViewController {

}
