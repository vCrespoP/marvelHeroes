
import Foundation

import NetworkKit

import ObjectMapper

extension Hero: StaticMappable {

    public static func objectForMapping(map: Map) -> BaseMappable? {
        return Hero()
    }

    public mutating func mapping(map: Map) {
        name        <- map["name"]
        photoUrl    <- map["photo"]
        realName    <- map["realName"]
        height      <- map["height"]
        power       <- map["power"]
        abilities   <- map["abilities"]
        groups      <- map["groups"]
    }

}

// MARK: Code Autogeneration
extension Hero: Serializable { }

