//
//  MultipartParameter.swift

import Foundation

public struct BackendMultipartParameter {
    public var data: Data
    public var fileParameter: BackendMultipartFileParameter?

    public init(data: Data, fileParameter: BackendMultipartFileParameter?) {
        self.data = data
        self.fileParameter = fileParameter
    }
}

// MARK: Equatable
extension BackendMultipartParameter: Equatable {
    static public func == (left: BackendMultipartParameter, right: BackendMultipartParameter) -> Bool {
        guard left.data == right.data else { return false }
        guard left.fileParameter == right.fileParameter else { return false }

        return true
    }
}

// MARK: Hashable
extension BackendMultipartParameter {
    public var hashValue: Int {
        let fileHash = fileParameter?.hashValue ?? 0
        return "\(data.hashValue),\(fileHash)".hashValue
    }
}
