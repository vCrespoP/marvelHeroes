//
//  Meta.swift

import Foundation
import NetworkKit

import ObjectMapper

extension Meta: StaticMappable {

    public static func objectForMapping(map: Map) -> BaseMappable? {
        return Meta()
    }

    public mutating func mapping(map: Map) {

    }

}

extension Meta: Serializable { }
