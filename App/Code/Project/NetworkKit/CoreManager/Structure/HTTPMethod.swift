//
//  HTTPMethod.swift

import Foundation

public enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
}

extension HTTPMethod: AutoCases, AutoEquatableCustom, AutoHashableCustom { }
