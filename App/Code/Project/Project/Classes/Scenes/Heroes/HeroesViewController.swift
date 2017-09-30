
import UIKit

import Domain

import RxSwift
import RxCocoa

// Enum with view layout
enum ShuffleState {
    case table
    case collection1
    case collection2
}

class HeroesViewController: BaseViewController {

    // MARK: - Properties
    var presenter: HeroesPresenter?
    var shuffleState: ShuffleState = .table

    // MARK: - Outlets
    var refreshControl: UIRefreshControl = UIRefreshControl()
    var refreshControlCv: UIRefreshControl = UIRefreshControl()
    let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet weak var tvHeroes: HeroesTableView!
    @IBOutlet weak var btShuffle: UIBarButtonItem!
    @IBOutlet weak var btAbout: UIBarButtonItem!
    @IBOutlet weak var cvHeroes: HeroCollectionView!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Initialization
    override func translation() {
        self.title = "HEROES_TITLE".localized
    }

    override func initUI() {
        super.initUI()

        self.refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        self.refreshControl.tintColor = ThemeColor.fontPrimaryLight
        self.tvHeroes.refreshControl = refreshControl

        self.refreshControlCv.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        self.refreshControlCv.tintColor = ThemeColor.fontPrimaryLight
        self.cvHeroes.refreshControl = refreshControlCv

        self.tvHeroes.heroesDelegate = self
        self.cvHeroes.heroesDelegate = self

        self.configureView(for: self.shuffleState)

        self.searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        self.tvHeroes.tableHeaderView = searchController.searchBar

        self.configureSearchBar()

        self.reloadUI()
    }

    @objc func refreshData(_ sender: Any) {
        self.presenter?.getHeroes()
    }

}

// MARK: IBActions
extension HeroesViewController {

    @IBAction func btShuffleTap(_ sender: UIBarButtonItem) {
        switch self.shuffleState {
        case .table:
            self.shuffleState = .collection1
        case .collection1:
            self.shuffleState = .collection2
        case .collection2:
            self.shuffleState = .table
        }
        self.configureView(for: self.shuffleState)
    }

    @IBAction func btAboutTap(_ sender: UIBarButtonItem) {
        let message = Message(title: "HEROES_WARNING_EXTERNAL_LINK_TITLE".localized, text: "HEROES_WARNING_EXTERNAL_LINK_TEXT".localized)
        let messageActionCancel = MessageAction(title: "GLOBAL_CANCEL".localized, style: .cancel)
        let messageActionAccept = MessageAction(title: "GLOBAL_ACCEPT".localized, style: .default, handler: { [weak self] in
            self?.presenter?.toAbout()
        })
        self.showConfirmation(message: message, accept: messageActionAccept, cancel: messageActionCancel)

    }

}

// MARK: Heroes Delegate
extension HeroesViewController: HeroesDelegate {

    func heroSelected(hero: Hero) {
        self.presenter?.toHeroDetails(hero: hero)
    }

}

// MARK: - Public methods
extension HeroesViewController {

    func reloadUI() {
        self.tvHeroes.dataSourceItems = self.presenter?.dataSourceFiltered
        self.cvHeroes.dataSourceItems = self.presenter?.dataSourceFiltered
    }

}

// MARK: - Private methods
extension HeroesViewController {

    fileprivate func configureView(for shuffleState: ShuffleState) {
        self.searchController.searchBar.text = ""
        switch shuffleState {
        case .table:
            self.tvHeroes.isHidden = false
            self.cvHeroes.isHidden = true
        case .collection1:
            self.tvHeroes.isHidden = true
            self.cvHeroes.isHidden = false
            self.cvHeroes.columns = 1
        case .collection2:
            self.tvHeroes.isHidden = true
            self.cvHeroes.isHidden = false
            self.cvHeroes.columns = 2
        }
    }

    fileprivate func configureSearchBar() {
        UISearchBar.appearance().barTintColor = ThemeColor.bgPrimaryDark
        UISearchBar.appearance().tintColor = ThemeColor.fontPrimaryLight
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = ThemeColor.bgPrimaryDark

        searchController.searchBar.rx.text.orEmpty
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] query in
                self?.presenter?.filterHeroes(query: query)
            })
            .addDisposableTo(self.disposeBag)

        searchController.searchBar.rx.cancelButtonClicked
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] query in
                self?.presenter?.filterHeroes(query: nil)
            })
            .addDisposableTo(self.disposeBag)

    }

}
