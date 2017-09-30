//
//  Network.swift

import Foundation
import NetworkKit
import Alamofire

public class NetworkAlamofire: NetworkService {

    public let baseUrl: String

    public required init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

}

extension NetworkAlamofire {

    // swiftlint:disable function_parameter_count
    public func request(
        url: URL,
        method: NetworkKit.HTTPMethod,
        headers: [String: String]?,
        parameters: [String: Any]?,
        parametersEncoding: BackendAPIRequestParametersEncoding,
        successCodes: Range<Int>,
        success: @escaping RequestSuccessHandler,
        failure: @escaping RequestFailureHandler) {

        let encodingAlamofire = parametersEncoding.alamofireEncoding
        let methodAlamofire = method.alamofireEncoding
        let successCodesArray = Array(successCodes.lowerBound ..< successCodes.upperBound)

        Alamofire
            .request(
                url,
                method: methodAlamofire,
                parameters: parameters,
                encoding: encodingAlamofire,
                headers: headers)
            .validate(statusCode: successCodesArray)
            .response(completionHandler: { response in

                let responseHTTP = response.response
                let data = response.data
                let error = response.error

                let statusCode = responseHTTP?.statusCode ?? 9999

                guard error == nil else {
                    failure(data, statusCode)
                    return
                }

                success(data, statusCode)
            })

    }
    // swiftlint:enable function_parameter_count

    // swiftlint:disable function_parameter_count
    public func uploadMultipart(
        url: URL,
        method: NetworkKit.HTTPMethod,
        headers: [String: String]?,
        parameters: [String: BackendMultipartParameter],
        successCodes: Range<Int>,
        success: @escaping RequestSuccessHandler,
        failure: @escaping RequestFailureHandler) {

        let methodAlamofire = method.alamofireEncoding

        Alamofire
            .upload(multipartFormData: { formData in
                for (name, parameter) in parameters {
                    let data: Data = parameter.data
                    guard let fileParameter = parameter.fileParameter else {
                        formData.append(data, withName: name)
                        continue
                    }
                    if let fileName = fileParameter.fileName {
                        let stream = InputStream(data: data)
                        let length = UInt64(data.count)
                        formData.append(stream, withLength: length, name: name, fileName: fileName, mimeType: fileParameter.mimeType)
                    } else {
                        formData.append(data, withName: name, mimeType: fileParameter.mimeType)
                    }
                }
            },
                    to: url,
                    method: methodAlamofire,
                    headers: headers,
                    encodingCompletion: { encodingResult in
                        switch encodingResult {
                        case .success(let request, _, _):
                            request.response { response in

                                let responseHTTP = response.response
                                let data = response.data
                                let error = response.error

                                let statusCode = responseHTTP?.statusCode ?? 9999

                                guard error == nil else {
                                    failure(data, statusCode)
                                    return
                                }

                                success(data, statusCode)
                            }

                        case .failure(_):
                            failure(nil, 599)
                        }
            })

    }
    // swiftlint:enable function_parameter_count

}

extension NetworkAlamofire {

    fileprivate func handleResponse(
        response: DefaultDataResponse,
        success: @escaping RequestSuccessHandler,
        failure: @escaping RequestFailureHandler) {

    }

}

extension NetworkKit.HTTPMethod {

    var alamofireEncoding: Alamofire.HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .delete:
            return .delete
        }
    }

}

extension BackendAPIRequestParametersEncoding {

    var alamofireEncoding: Alamofire.ParameterEncoding {
        switch self {
        case .json:
            return JSONEncoding.default
        case .url:
            return URLEncoding.default
        }
    }

}

