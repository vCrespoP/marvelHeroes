//
//  ApiRequestRx.swift

import Foundation

import Domain
import NetworkKit
import NetworkSpecific
import RxSwift

class ApiUtils {

    static func apiRequest<T: Serializable, U: NetworkService>(networkApi: NetworkApi<U>, request: BackendAPIRequest) -> Observable<SuccessResponse<T>> {

        return Observable.create { observable in

            networkApi.request(request, success: { data, statusCode in

                guard let item = T.parse(from: data?.data) else {
                    let error = ErrorResponse.from(serverResponse: data, statusCode: statusCode)
                    return observable.onError(error)
                }
                observable.onNext(SuccessResponse(data: item, statusCode: statusCode))
                observable.onCompleted()

            }, failure: { data, statusCode in
                let error = ErrorResponse.from(serverResponse: data, statusCode: statusCode)
                observable.onError(error)
            })

            return Disposables.create {
                // TODO: Cancel network request
            }

        }

    }

}
