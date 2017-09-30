//
//  UseCaseDataSourceProvider.swift

import Foundation

import Domain

public final class UseCaseDataSourceProvider: Domain.UseCaseDataSourceProvider {

    // MARK: - Properties
    private let responseType: ResponseType
    private let delay: TimeInterval

    // MARK: - Life Cycle
    public init(responseType: ResponseType = .success(code: 200), delay: TimeInterval = 0.0) {
        self.responseType = responseType
        self.delay = delay
    }

    // MARK: - Heroes
    public func makeUseCaseGetHeroes() -> Domain.UseCaseHeroesDataSource {
        return UseCaseHeroesDataSource(responseType: self.responseType, delay: self.delay)
    }

}
