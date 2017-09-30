//
//  ServerResponse.swift

import Foundation

import NetworkKit

import ObjectMapper

extension ApiResponse: StaticMappable {

    public static func objectForMapping(map: Map) -> BaseMappable? {
        return ApiResponse()
    }

    public mutating func mapping(map: Map) {
        meta          <- map["meta"]
        message       <- map["message"]
        data          <- map["data"]
    }

}

extension ApiResponse: Serializable { }

