//
//  ServerResponse.swift

import Foundation

public struct ApiResponse {

    public var meta: Meta?
    public var message: ApiMessage?
    public var data: [String:Any]?
    public var statusCode: Int = 9999

    public init() { }

    public init(data: [String:Any]?, statusCode: Int = 9999) {
        self.data = data
        self.statusCode = statusCode
    }

}

