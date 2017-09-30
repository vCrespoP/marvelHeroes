
import UIKit

class UIButtonBase: UIButton {

    var heightC: NSLayoutConstraint?

    public override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }

    override func awakeFromNib() {
        super.awakeFromNib()

        commonInit()
    }

    func commonInit() {

        let appearance = self.appearanceModel

        let noPadding: CGFloat = 0.0
        let smallPadding: CGFloat = 5.0
        let mediumPadding: CGFloat = 12.0

        if self.currentImage != nil {
            if self.titleLabel?.text != nil {
                self.contentEdgeInsets = UIEdgeInsets(top:smallPadding, left:noPadding, bottom:smallPadding, right:mediumPadding)
            } else {
                self.contentEdgeInsets = UIEdgeInsets(top:smallPadding, left:smallPadding, bottom:smallPadding, right:smallPadding)
            }
        } else {
            self.contentEdgeInsets = UIEdgeInsets(top:mediumPadding, left:mediumPadding, bottom:mediumPadding, right:mediumPadding)
        }

        // Override isnets if they are defined
        if let insets = appearance.insets {
            self.contentEdgeInsets = insets
        }

        // Define height
        if let heightC = self.heightC {
            self.removeConstraint(heightC)
        }

        self.heightC = appearance.height.map {
            self.autoSetDimension(.height, toSize: $0)
        }

        // Size
        if let font = appearance.font {
            self.titleLabel?.font = font
        }
        self.titleLabel?.minimumScaleFactor = 0.7
        self.adjustsImageWhenHighlighted = false

        // Background
        if let backgroundColorNormal = appearance.backgroundColorNormal {
            self.setBackgroundColor(backgroundColorNormal, for: .normal)
        }
        if let backgroundColorHighlighted = appearance.backgroundColorHighlighted {
            self.setBackgroundColor(backgroundColorHighlighted, for: .highlighted)
        }
        if let backgroundColorDisabled = appearance.backgroundColorDisabled {
            self.setBackgroundColor(backgroundColorDisabled, for: .disabled)
        }

        // Text
        self.setTitleColor(appearance.textColorNormal, for: .normal)
        self.setTitleColor(appearance.textColorDisabled, for: .disabled)
        self.setTitleColor(appearance.textColorSelected, for: .highlighted)
        self.setTitleColor(appearance.textColorSelected, for: .selected)

        // Image
        self.imageView?.contentMode = .scaleAspectFit
        self.tintColor = UIColor.white
    }

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? self.appearanceModel.backgroundColorHighlighted : self.appearanceModel.backgroundColorNormal
        }
    }

    override func setTitle(_ title: String?, for state: UIControlState) {
        guard let titleTransformation = self.appearanceModel.titleTransformation else {
            super.setTitle(title, for: state)
            return
        }
        let newTitle = titleTransformation(title)
        super.setTitle(newTitle, for: state)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let appearance = self.appearanceModel
        self.layer.cornerRadius = appearance.cornerRadius ?? 0
        self.clipsToBounds = true
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.layer.cornerRadius).cgPath
    }

    var appearanceModel: ButtonAppearanceModel {
        return ButtonAppearanceModel.default
    }

}

