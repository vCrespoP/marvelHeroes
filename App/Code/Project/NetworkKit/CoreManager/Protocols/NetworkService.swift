//
//  NetworkService.swift

import Foundation

public protocol NetworkService {

    var baseUrl: String { get }
    init(baseUrl: String)

    typealias RequestSuccessHandler = (_ data: Data?, _ responseCode: Int) -> Void
    typealias RequestFailureHandler = (_ data: Data?, _ responseCode: Int) -> Void

    // swiftlint:disable function_parameter_count
    func request(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]?,
        parameters: [String: Any]?,
        parametersEncoding: BackendAPIRequestParametersEncoding,
        successCodes: Range<Int>,
        success: @escaping RequestSuccessHandler,
        failure: @escaping RequestFailureHandler
    )
    // swiftlint:enable function_parameter_count

    // swiftlint:disable function_parameter_count
    func uploadMultipart(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]?,
        parameters: [String: BackendMultipartParameter],
        successCodes: Range<Int>,
        success: @escaping RequestSuccessHandler,
        failure: @escaping RequestFailureHandler)
    // swiftlint:enable function_parameter_count
}

