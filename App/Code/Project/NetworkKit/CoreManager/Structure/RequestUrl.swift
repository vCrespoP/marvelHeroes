//
//  BackendAPIRequestUrl.swift

import Foundation

public enum BackendAPIRequestUrl {
    case endpoint(String)
    case full(String)
}

extension BackendAPIRequestUrl: AutoCases, AutoEquatableCustom, AutoHashableCustom { }

