//
//  Array+Hash.swift

import Foundation

extension Array where Element: Hashable {
    public var hashValue: Int {
        let result = self.reduce(5381) {
            ($0 << 5) &+ $0 &+ $1.hashValue
        }
        return result
    }
}

