//
//  ServerError.swift

import Foundation

public struct NetworkError: Error {

    public let data: Data?
    public let statusCode: Int

    public init(data: Data? = nil, statusCode: Int = 9999) {
        self.data = data
        self.statusCode = statusCode
    }

}

extension NetworkError: AutoEquatableCustom, AutoHashableCustom { }
