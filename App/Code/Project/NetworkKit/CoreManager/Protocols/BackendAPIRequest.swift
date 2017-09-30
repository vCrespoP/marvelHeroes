//
//  ProtocolBackendAPIRequest.swift

import Foundation

public struct BackendAPIRequest {
    public var method: HTTPMethod
    public var url: BackendAPIRequestUrl
    public var type: BackendAPIRequestType
    public var timeout: TimeInterval
    public var headers: [String: String]?
    public var successCodes: Range<Int>

    public init(
        method: HTTPMethod = .get,
        url: BackendAPIRequestUrl,
        type: BackendAPIRequestType = BackendAPIRequestType.default,
        timeout: TimeInterval = 50,
        headers: [String: String]? = nil,
        successCodes: Range<Int> = 200 ..< 299) {
        self.method = method
        self.url = url
        self.type = type
        self.timeout = timeout
        self.headers = headers
        self.successCodes = successCodes
    }

}

extension BackendAPIRequest {

    public func fullUrl(baseUrl: URL? = nil) -> URL? {
        switch self.url {
        case .endpoint(let endpoint):
            guard let baseUrl = baseUrl else { return nil }
            let result = URL(string: baseUrl.absoluteString)?.appendingPathComponent(endpoint)
            return result
        case .full(let full):
            return URL(string: full)
        }
    }

}

