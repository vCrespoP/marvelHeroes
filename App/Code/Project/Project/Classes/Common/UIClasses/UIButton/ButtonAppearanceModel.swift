//
//  ButtonAppearanceModel.swift

import Foundation
import UIKit

public struct ButtonAppearanceModel {

    public var height: CGFloat?
    public var cornerRadius: CGFloat?

    public var font: UIFont?

    public var textColorNormal: UIColor?
    public var textColorSelected: UIColor?
    public var textColorDisabled: UIColor?

    public var backgroundColorNormal: UIColor?
    public var backgroundColorDisabled: UIColor?
    public var backgroundColorHighlighted: UIColor?

    public var insets: UIEdgeInsets?

    public typealias StringTransformation = (_ title: String?) -> (String?)
    public var titleTransformation: StringTransformation?

    public init(
        height: CGFloat? = nil,
        cornerRadius: CGFloat? = nil,
        font: UIFont? = nil,
        textColorNormal: UIColor? = nil,
        textColorSelected: UIColor? = nil,
        textColorDisabled: UIColor? = nil,
        backgroundColorNormal: UIColor? = nil,
        backgroundColorDisabled: UIColor? = nil,
        backgroundColorHighlighted: UIColor? = nil,
        insets: UIEdgeInsets? = nil,
        titleTransformation: StringTransformation? = nil
        ) {
        self.height = height
        self.cornerRadius = cornerRadius
        self.font = font
        self.textColorNormal = textColorNormal
        self.textColorSelected = textColorSelected
        self.textColorDisabled = textColorDisabled
        self.backgroundColorNormal = backgroundColorNormal
        self.backgroundColorDisabled = backgroundColorDisabled
        self.backgroundColorHighlighted = backgroundColorHighlighted
        self.insets = insets
        self.titleTransformation = titleTransformation
    }

}
extension ButtonAppearanceModel {

    public static var `default`: ButtonAppearanceModel {
        return ButtonAppearanceModel(
            height: 40.0,
            cornerRadius: 3.0,
            font: UIFont.boldSystemFont(ofSize: 18.0),
            textColorNormal: UIColor.black,
            textColorSelected: UIColor.lightGray,
            textColorDisabled: UIColor.lightGray,
            backgroundColorNormal: UIColor.clear,
            backgroundColorDisabled: UIColor.clear,
            backgroundColorHighlighted: UIColor.clear,
            insets: nil,
            titleTransformation: nil
        )
    }

}
