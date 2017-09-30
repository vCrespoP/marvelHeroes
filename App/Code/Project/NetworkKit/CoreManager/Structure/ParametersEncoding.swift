//
//  BackendAPIRequestParametersEncoding.swift

import Foundation

public enum BackendAPIRequestParametersEncoding {
    case url
    case json
}

extension BackendAPIRequestParametersEncoding: AutoCases, AutoEquatableCustom, AutoHashableCustom { }

