//
//  TRNStateFulViewDefault.swift

import Foundation
import UIKit

import PureLayout

class ViewStatefulDefault: UIView, StatefulViewProtocol {

    // MARK: Properties
    var statefulViewModel: StatefulViewModel?

    // MARK: IBOutlets
    @IBOutlet weak var lbText: UILabel!
    @IBOutlet weak var lbImage: UIImageView!
    @IBOutlet weak var btAction: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        commonInit()
    }

    fileprivate func commonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}

extension ViewStatefulDefault {

    class func createView() -> ViewStatefulDefault? {
        let name = "ViewStatefulDefault"
        let view = Bundle.main
            .loadNibNamed(name, owner: self, options: nil)?
            .first as? ViewStatefulDefault
        view?.commonInit()
        return view
    }

    class func createView(in view: UIView) -> ViewStatefulDefault? {
        guard let newView = createView() else {
            return nil
        }

        view.addSubview(newView)
        newView.autoPinEdgesToSuperviewEdges()
        return newView
    }

}

extension ViewStatefulDefault {

    @IBAction func btActionTap(_ sender: UIButton) {
        statefulViewModel?.handler?()
    }

}

extension ViewStatefulDefault {

    func fill(_ value: StatefulViewModel) {

        self.backgroundColor = ThemeColor.bgPrimaryDark

        self.statefulViewModel = value

        lbText.isHidden = value.text == nil
        lbText.styleTitle3()
        lbText.text = value.text

        lbImage.isHidden = value.image == nil
        lbImage.image = value.image

        btAction.isHidden = value.handler == nil

        btAction.setTitle(value.buttonText, for: .normal)
        btAction.setImage(value.buttonImage, for: .normal)
    }

}

