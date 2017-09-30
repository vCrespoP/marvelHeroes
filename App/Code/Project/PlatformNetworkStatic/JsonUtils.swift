//
//  JsonUtils.swift

import Foundation

class JsonUtils {

    static func readDictionary(resourceName: String, bundle: Bundle = Bundle.main) -> [String: Any]? {

        guard let resourceUrl = bundle.url(forResource: resourceName, withExtension: "json") else {
            return nil
        }
        guard let content = try? String(contentsOf: resourceUrl) else {
            return nil
        }

        return readJson(content) as? [String: Any]
    }

    fileprivate static func readJson(_ content: String) -> Any? {
        guard let contentData = content.data(using: .utf8) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: contentData, options: [])
    }

}
