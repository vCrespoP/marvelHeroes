//
//  ThemeConfigurator.swift

import Foundation
import UIKit

enum Fonts: String {
    case Ubuntu = "Ubuntu"
    case UbuntuBold = "Ubuntu-Bold"

    case System = "HelveticaNeue"
    case SystemBold = "HelveticaNeue-Bold"

    func of(size: CGFloat) -> UIFont {
        let calculatedSize = UIScreen.main.scale > 2 ? size : size - 1
        return UIFont(name: self.rawValue, size: calculatedSize)!
    }

    func forStyle(_ style: UIFontTextStyle) -> UIFont {
        let calculatedSize = UIFont.preferredFont(forTextStyle: style).pointSize
        return UIFont(name: self.rawValue, size: calculatedSize)!
    }

}

struct FontStyle {

    static var body: UIFont {
        return Fonts.System.forStyle(.body)
    }

    static var title1: UIFont {
        return Fonts.SystemBold.forStyle(.title1)
    }

    static var title2: UIFont {
        return Fonts.SystemBold.forStyle(.title2)
    }

    static var title3: UIFont {
        return Fonts.SystemBold.forStyle(.title3)
    }

    static var headline: UIFont {
        return Fonts.SystemBold.forStyle(.headline)
    }

    static var subheadline: UIFont {
        return Fonts.SystemBold.forStyle(.subheadline)
    }

    static var footnote: UIFont {
        return Fonts.System.forStyle(.footnote)
    }

    static var caption1: UIFont {
        return Fonts.System.forStyle(.caption1)
    }

    static var caption2: UIFont {
        return Fonts.System.forStyle(.caption2)
    }

}

extension UILabel {

    func styleBody() {
        self.font = FontStyle.body
        self.textColor = ThemeColor.fontPrimaryLight
    }

    func styleTitle1() {
        self.font = FontStyle.title1
        self.textColor = ThemeColor.fontPrimaryLight
    }

    func styleTitle2() {
        self.font = FontStyle.title2
        self.textColor = ThemeColor.fontPrimaryLight
    }

    func styleTitle3() {
        self.font = FontStyle.title3
        self.textColor = ThemeColor.fontPrimaryLight
    }

    func styleHeadline() {
        self.font = FontStyle.headline
        self.textColor = ThemeColor.fontPrimaryLight
    }

    func styleSubheadline() {
        self.font = FontStyle.subheadline
        self.textColor = ThemeColor.fontPrimaryLight
    }

    func styleFootnote() {
        self.font = FontStyle.footnote
        self.textColor = ThemeColor.fontPrimaryLight
    }

    func styleCaption1() {
        self.font = FontStyle.caption1
        self.textColor = ThemeColor.fontPrimaryLight
    }

    func styleCaption2() {
        self.font = FontStyle.caption2
        self.textColor = ThemeColor.fontPrimaryLight
    }

}
