//
//  ApiMessage.swift

import Foundation

public struct ApiMessage {

    public var title: String?
    public var text: String?

}

extension ApiMessage: AutoEquatableCustom, AutoHashableCustom { }

