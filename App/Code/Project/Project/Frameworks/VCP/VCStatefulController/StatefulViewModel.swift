//
//  StatefulViewModel.swift
//  Project
//
//  Created by José Manuel Sánchez Peñarroja on 15/6/17.
//  Copyright © 2017 treeNovum. All rights reserved.
//

import UIKit

import Domain
import SharedUtils

struct StatefulViewModel {
    typealias TRNStatefulViewHandler = () -> Void

    var text: String?
    var image: UIImage?
    var buttonText: String?
    var buttonImage: UIImage?

    var handler: TRNStatefulViewHandler?

    init(text: String? = nil, image: UIImage? = nil, buttonText: String? = nil, buttonImage: UIImage? = nil, handler: TRNStatefulViewHandler? = nil) {
        self.text = text
        self.image = image
        self.buttonText = buttonText
        self.buttonImage = buttonImage
        self.handler = handler
    }
}

extension StatefulViewModel: Equatable {}
internal func == (lhs: StatefulViewModel, rhs: StatefulViewModel) -> Bool {
    guard equalOptionals(lhs.text, rhs.text) else { return false }
    guard equalOptionals(lhs.image, rhs.image) else { return false }
    guard equalOptionals(lhs.buttonText, rhs.buttonText) else { return false }
    guard equalOptionals(lhs.buttonImage, rhs.buttonImage) else { return false }
    return true
}

// MARK: - StatefulViewModel Hashable
extension StatefulViewModel: Hashable {

    internal var hashValue: Int {
        let strings = [
            "\(String(describing: text?.hashValue))",
            "\(String(describing: image?.hashValue))",
            "\(String(describing: buttonText?.hashValue))",
            "\(String(describing: buttonImage?.hashValue))"
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}

extension StatefulViewModel {
    static var loading: StatefulViewModel {
        return StatefulViewModel(text: "Loading...")
    }

    static var info: StatefulViewModel {
        return StatefulViewModel(text: "GLOBAL_NO_DATA_TEXT".localized)
    }

    static var error: StatefulViewModel {
        return StatefulViewModel(text: "Error")
    }

    static func infoReload(_ handler: @escaping TRNStatefulViewHandler) -> StatefulViewModel {
        return StatefulViewModel(text: "GLOBAL_NO_DATA_TEXT".localized, buttonText: "Reload", handler: handler)
    }

    static func errorReload(_ handler: @escaping TRNStatefulViewHandler) -> StatefulViewModel {
        return StatefulViewModel(text: "GLOBAL_SERVER_ERROR_TEXT".localized, buttonText: "GLOBAL_RELOAD".localized, handler: handler)
    }

}

