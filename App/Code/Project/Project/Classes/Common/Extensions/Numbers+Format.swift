//
//  Numbers+Format.swift

import Foundation

public extension Formatter {

    static let withSeparator: NumberFormatter = {

        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        return formatter
    } ()

}

public extension Int {

    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }

}

public extension Float {

    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }

    func format(decimals: Int) -> String {
        let format = String(decimals)
        return String(format: "%.\(format)f", self)
    }

}

