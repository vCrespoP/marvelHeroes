
import UIKit

class ButtonSmall: UIButtonBase {

    override var appearanceModel: ButtonAppearanceModel {

        return ButtonAppearanceModel(
            height: 24,
            cornerRadius: 0,
            font: Fonts.System.of(size: 12), // FontStyle.caption1,
            textColorNormal: ThemeColor.fontPrimaryDark1,
            textColorSelected: ThemeColor.fontPrimaryDisabled,
            textColorDisabled: ThemeColor.fontPrimaryDisabled,
            backgroundColorNormal: UIColor.clear,
            backgroundColorDisabled: UIColor.clear,
            backgroundColorHighlighted: UIColor.clear,
            insets: UIEdgeInsets(
                top: 8,
                left: 0,
                bottom: 8,
                right: 0)
        )
    }

}
