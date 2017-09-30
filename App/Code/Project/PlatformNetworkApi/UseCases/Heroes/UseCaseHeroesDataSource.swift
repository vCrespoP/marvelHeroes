//
//  AllUserGroupsUseCase.swift

import Foundation

import NetworkKit
import NetworkSpecific
import Domain

import RxSwift

final class UseCaseHeroesDataSource<T: NetworkService>: Domain.UseCaseHeroesDataSource {

    private let networkApi: NetworkApi<T>

    init(networkApi: NetworkApi<T>) {
        self.networkApi = networkApi
    }

    func getHeroes() -> Observable<SuccessResponse<Heroes>> {
        let request = HeroesRequest.apiRequest()
        return ApiUtils.apiRequest(networkApi: networkApi, request: request)
    }

}

