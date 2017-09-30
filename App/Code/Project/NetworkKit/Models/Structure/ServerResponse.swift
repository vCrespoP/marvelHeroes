//
//  NetworkSuccess.swift

import Foundation

public struct ServerResponse {

    public let data: Data?
    public let statusCode: Int

    public init(data: Data? = nil, statusCode: Int = 200) {
        self.data = data
        self.statusCode = statusCode
    }

}

extension ServerResponse: AutoEquatableCustom, AutoHashableCustom { }
