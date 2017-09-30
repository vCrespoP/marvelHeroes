//
//  ResponseType.swift

import Foundation

public enum ResponseType {
    case success(code: Int)
    case error(code: Int)
    case timeout(seconds: TimeInterval)
}

