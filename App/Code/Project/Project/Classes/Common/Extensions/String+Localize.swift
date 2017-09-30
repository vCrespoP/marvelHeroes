//
//  String+Localize.swift

import Foundation

extension String {

    var localized: String? {
        let result = NSLocalizedString(self, comment: "")
        return result
    }

}
