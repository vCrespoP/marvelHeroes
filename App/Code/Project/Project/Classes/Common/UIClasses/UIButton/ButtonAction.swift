//
//  SSActionButton.swift

import Foundation
import UIKit

class ButtonAction: UIButtonBase {

    override var appearanceModel: ButtonAppearanceModel {

        return ButtonAppearanceModel(
            height: 44,
            cornerRadius: 22,
            font: Fonts.SystemBold.of(size: 18), //FontStyle.headline,
            textColorNormal: ThemeColor.fontPrimaryLight,
            textColorSelected: ThemeColor.fontPrimaryDisabled,
            textColorDisabled: ThemeColor.fontPrimaryDisabled,
            backgroundColorNormal: ThemeColor.bgPrimaryDark,
            backgroundColorDisabled: ThemeColor.bgPrimaryDark,
            backgroundColorHighlighted: ThemeColor.bgPrimaryDark,
            insets: UIEdgeInsets(
                top: 8,
                left: 32,
                bottom: 8,
                right: 32),
            titleTransformation: {
                return $0?.uppercased()
        })
    }

}
