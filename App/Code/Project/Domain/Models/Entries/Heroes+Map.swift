//
//  Heroes+Map.swift
//  Domain
//
//  Created by Vicente Crespo on 29/9/17.
//

import Foundation

import NetworkKit

import ObjectMapper

extension Heroes: StaticMappable {

    public static func objectForMapping(map: Map) -> BaseMappable? {
        return Heroes()
    }

    public mutating func mapping(map: Map) {
        list        <- map["superheroes"]
    }

}

extension Heroes: Serializable { }

