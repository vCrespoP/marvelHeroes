//
//  ApiMessage.swift

import Foundation
import NetworkKit

import ObjectMapper

extension ApiMessage: StaticMappable {

    public static func objectForMapping(map: Map) -> BaseMappable? {
        return ApiMessage()
    }

    public mutating func mapping(map: Map) {
        title          <- map["title"]
        text           <- map["text"]
    }

}

extension ApiMessage: Serializable { }

