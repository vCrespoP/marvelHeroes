//
//  Empty.swift

import Foundation

public struct Empty {

    public init() { }

}

extension Empty: Hashable, Equatable {
    public static func ==(_ left: Empty, _ right: Empty) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }
}

extension Empty {

    public static var empty: Empty {
        return Empty()
    }

}
