//
//  RegistrationUseCasesDataSourceProvider.swift

import Foundation

public protocol UseCaseDataSourceProvider {

    // MARK: - Heroes
    func makeUseCaseGetHeroes() -> UseCaseHeroesDataSource

}
