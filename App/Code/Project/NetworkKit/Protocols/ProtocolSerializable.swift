//
//  ProtocolSerializable.swift

import Foundation

import ObjectMapper

public protocol Serializable: Parseable, StaticMappable {
    func toJson() -> [String : Any]
    func toJsonString() -> String?
}

extension Serializable {

    public static func parse(from item: Any?) -> Self? {

        if let itemData = item as? Data {
            guard let itemJson = try? JSONSerialization.jsonObject(with: itemData, options: []) else {
                return nil
            }
            return Mapper<Self>().map(JSONObject: itemJson)
        }

        if let itemString = item as? String {
            return Mapper<Self>().map(JSONString: itemString)
        }

        return Mapper<Self>().map(JSONObject: item)
    }

    public func toJsonString() -> String? {
        return Mapper().toJSONString(self, prettyPrint:false)
    }

    public func toJson() -> [String : Any] {
        return Mapper().toJSON(self)
    }
}

