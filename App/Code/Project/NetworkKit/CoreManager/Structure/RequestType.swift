//
//  RequestType.swift

import Foundation
import SharedUtils

public enum BackendAPIRequestType {
    case request(parameters: [String: Any]?, parametersEncoding: BackendAPIRequestParametersEncoding)
    case uploadMultipartData(parameters: [String: BackendMultipartParameter])

    public static var `default`: BackendAPIRequestType {
        return .request(parameters: nil, parametersEncoding: .url)
    }
}

// MARK: Equatable
extension BackendAPIRequestType: Equatable {
    static public func == (left: BackendAPIRequestType, right: BackendAPIRequestType) -> Bool {
        switch (left, right) {
        case (.request(let p1, let e1), .request(let p2, let e2)):
            return p1 == p2 && e1 == e2
        case (.uploadMultipartData(let p1), .uploadMultipartData(let p2)):
            return p1 == p2
        default:
            return false
        }
    }

}

// MARK: Hashable
extension BackendAPIRequestType {
    public var hashValue: Int {
        switch self {
        case .request(let params, let encoding):
            let paramsHash = NSDictionary(dictionary: params ?? [:]).hashValue
            return "request \(paramsHash) \(encoding.hashValue)".hashValue
        case .uploadMultipartData(let params):
            return "uploadMultipart \(NSDictionary(dictionary: params).hashValue)".hashValue
        }
    }
}

