//
//  AllUserGroupsUseCase.swift

import Foundation

import NetworkKit
import NetworkSpecific

import Domain
import RxSwift

final class UseCaseHeroesDataSource: Domain.UseCaseHeroesDataSource {

    private let responseType: ResponseType
    private let delay: TimeInterval

    init(responseType: ResponseType, delay: TimeInterval) {
        self.responseType = responseType
        self.delay = delay
    }

    public func getHeroes() -> Observable<SuccessResponse<Heroes>> {
        switch self.responseType {
        case .success(_):
            let json = JsonUtils.readDictionary(resourceName: "Heroes", bundle: Bundle(for: type(of: self)))
            let user = Heroes.parse(from: json)
            let response = SuccessResponse(data: user!)
            return Observable
                .just(response)
                .delaySubscription(RxTimeInterval(delay), scheduler: MainScheduler.instance)

        case .error(let code):
            let error = ErrorResponse(message: nil, statusCode: code)
            return Observable
                .error(error)
                .delaySubscription(RxTimeInterval(delay), scheduler: MainScheduler.instance)

        case .timeout(let seconds):
            let error = ErrorResponse(message: nil, statusCode: 9999)
            return Observable
                .error(error)
                .delaySubscription(RxTimeInterval(seconds), scheduler: MainScheduler.instance)

        }

    }

}

