//
//  MultipartFileParameter.swift

import Foundation

public struct BackendMultipartFileParameter {
    public var mimeType: String
    public var fileName: String?

    public init(mimeType: String, fileName: String?) {
        self.mimeType = mimeType
        self.fileName = fileName
    }
}

extension BackendMultipartFileParameter: AutoEquatableCustom, AutoHashableCustom { }
