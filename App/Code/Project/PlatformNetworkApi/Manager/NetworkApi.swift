//
//  NetworkService.swift

import Foundation

import NetworkKit
import NetworkSpecific

public class NetworkApi<T: NetworkService> {

    var service: T

    public init(service: T) {
        self.service = service
    }

}

extension NetworkApi {

    // Parse response to message/error/whatever so all it's done globally
    public typealias SuccessHandler = (_ response: ApiResponse?, _ statusCode: Int) -> Void
    public typealias FailureHandler = (_ response: ApiResponse?, _ statusCode: Int) -> Void

    public func request(_ request: BackendAPIRequest, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {

        guard let url = request.fullUrl(baseUrl: URL(string: service.baseUrl)) else {
            return
        }

        switch request.type {
        case .request(let parameters, let parametersEncoding):
            self.request(
                url: url,
                method: request.method,
                headers: request.headers,
                parameters: parameters,
                parametersEncoding: parametersEncoding,
                successCodes: request.successCodes,
                success: success,
                failure: failure
            )

        case .uploadMultipartData(let parameters):

            self.uploadMultipart(
                url: url,
                method: request.method,
                headers: request.headers,
                parameters: parameters,
                successCodes: request.successCodes,
                success: success,
                failure:failure
            )
        }

    }

    // swiftlint:disable function_parameter_count
    fileprivate func request(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]?,
        parameters: [String: Any]?,
        parametersEncoding: BackendAPIRequestParametersEncoding,
        successCodes: Range<Int>,
        success: @escaping SuccessHandler,
        failure: @escaping FailureHandler
        ) {

        service.request(
            url: url,
            method: method,
            headers: headers,
            parameters: parameters,
            parametersEncoding: parametersEncoding,
            successCodes: successCodes,
            success: { (data, statusCode) in
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print(" * * NETWORK RESPONSE SUCCESS: \n \(responseString)")
                }
                self.processSuccessServerResponse(data: data, statusCode: statusCode, success: success, failure: failure)

        },
            failure: { (data, statusCode) in
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print(" * * NETWORK RESPONSE ERROR: \n \(responseString)")
                }
                self.processFailureServerResponse(data: data, statusCode: statusCode, failure: failure)
        })

    }
    // swiftlint:enable function_parameter_count

    // swiftlint:disable function_parameter_count
    fileprivate func uploadMultipart(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]?,
        parameters: [String: BackendMultipartParameter],
        successCodes: Range<Int>,
        success: @escaping SuccessHandler,
        failure: @escaping FailureHandler) {

        service.uploadMultipart(
            url: url,
            method: method,
            headers: headers,
            parameters: parameters,
            successCodes: successCodes,
            success: { (data, statusCode) in

                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print(" * * NETWORK RESPONSE SUCCESS: \n \(responseString)")
                }

                self.processSuccessServerResponse(data: data, statusCode: statusCode, success: success, failure: failure)

        },
            failure: { (data, statusCode) in

                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print(" * * NETWORK RESPONSE ERROR: \n \(responseString)")
                }

                self.processFailureServerResponse(data: data, statusCode: statusCode, failure: failure)

        })

    }
    // swiftlint:enable function_parameter_count

}

extension NetworkApi {

    fileprivate func processSuccessServerResponse(data: Data?, statusCode: Int, success: SuccessHandler, failure: FailureHandler) {

        // No data, but success response
        guard let data = data else {
            success(nil, statusCode)
            return
        }

        // Data, check for Json or fail
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        guard let jsonDict = json as? [String: Any] else {
            let serverResponse = ApiResponse(data: nil, statusCode: statusCode)
            failure(serverResponse, statusCode)
            return
        }

        // Check if the format can be parsed to the global structure
        let jsonParsed = ApiResponse(data: jsonDict, statusCode: statusCode)

        // Finally, return success response
        success(jsonParsed, statusCode)

    }

    fileprivate func processFailureServerResponse(data: Data?, statusCode: Int, failure: FailureHandler) {

        // No data, but failure response
        guard let data = data else {
            failure(nil, statusCode)
            return
        }

        // Data, check for Json or fail
        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        guard let jsonDict = json as? [String: Any] else {
            let serverResponse = ApiResponse(data: nil, statusCode: statusCode)
            failure(serverResponse, statusCode)
            return
        }

        // Check if the format can be parsed to the global structure
        guard let jsonParsed = ApiResponse.parse(from: jsonDict) else {
            let serverResponse = ApiResponse(data: nil, statusCode: statusCode)
            failure(serverResponse, statusCode)
            return
        }

        // Finally, return success response
        failure(jsonParsed, statusCode)

    }

}

