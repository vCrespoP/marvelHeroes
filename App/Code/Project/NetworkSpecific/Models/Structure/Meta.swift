//
//  Meta.swift

import Foundation

public struct Meta {

    var apiVersion: String?

    public init() { }

}

extension Meta: AutoEquatableCustom, AutoHashableCustom { }

