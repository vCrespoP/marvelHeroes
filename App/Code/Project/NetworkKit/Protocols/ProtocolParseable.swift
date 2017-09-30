//
//  ProtocolParseable.swift

import Foundation

public protocol Parseable {
    static func parse(from item: Any?) -> Self?
}
