//
//  ErrorResponse.swift

import Foundation

public struct ErrorResponse: Error {

    public var message: ApiMessage?
    public var statusCode: Int = 9999

    public init() { }

    public init(message: ApiMessage?, statusCode: Int = 9999) {
        self.message = message
        self.statusCode = statusCode
    }

}

extension ErrorResponse: AutoEquatableCustom, AutoHashableCustom { }

extension ErrorResponse {

    public static func from(serverResponse: ApiResponse?, statusCode: Int) -> ErrorResponse {
        return ErrorResponse(message: serverResponse?.message, statusCode: statusCode)
    }

}

