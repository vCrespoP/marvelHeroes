//
//  Empty+Map.swift

import Foundation

import NetworkKit

import ObjectMapper

extension Empty: StaticMappable {

    public static func objectForMapping(map: Map) -> BaseMappable? {
        return Empty()
    }

    public mutating func mapping(map: Map) {

    }

}

extension Empty: Serializable { }
