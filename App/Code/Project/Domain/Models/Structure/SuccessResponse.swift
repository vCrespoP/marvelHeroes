//
//  SuccessResponse.swift
//  NetworkSpecific
//
//  Created by Sento Crespo on 30/9/17.
//

import Foundation

import NetworkKit
import SharedUtils

public struct SuccessResponse<T: Serializable & Hashable> {

    public var data: T
    public var statusCode: Int?

    public init(data: T, statusCode: Int? = nil) {
        self.data = data
        self.statusCode = statusCode
    }

}

extension SuccessResponse: Equatable, Hashable {
    public static func == <T>(_ left: SuccessResponse<T>, _ right: SuccessResponse<T>) -> Bool {
        return left.data == right.data && equalOptionals(left.statusCode, right.statusCode)
    }

    public var hashValue: Int {
        let dataHash = data.hashValue
        let codeHash = statusCode?.hashValue ?? 0
        return "\(dataHash), \(codeHash)".hashValue
    }
}

