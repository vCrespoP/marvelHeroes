//
//  LoginRequest.swift

import Foundation

import NetworkKit

public enum HeroesRequest {

    public static func apiRequest() -> BackendAPIRequest {

        let parameters: [String: Any] = [:]

        let headers: [String : String]? = [:]

        let result = BackendAPIRequest(
            method: .get,
            url: .endpoint("/bins/bvyob"),
            type: .request(parameters: parameters, parametersEncoding: .url),
            headers: headers)

        return result

    }

}

