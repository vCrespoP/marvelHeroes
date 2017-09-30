//
//  UseCaseProvider.swift

import Foundation
import Domain

public enum ApiEnvironment {
    case debug
    case integration
    case demo
    case production
}

public class UseCaseDataSourceProvider: Domain.UseCaseDataSourceProvider {

    // MARK: - Properties
    private let networkApi: NetworkApi<NetworkAlamofire>

    // MARK: - Life Cycle
    public init(environment: ApiEnvironment) {
        let baseUrl: String
        switch environment {
        case .debug:
            baseUrl = "http://192.168.0.1"
        case .integration:
            baseUrl = "https://api.myjson.com"
        case .demo:
            baseUrl = "https://api.myjson.com"
        case .production:
            baseUrl = "https://api.myjson.com"
        }

        let alamofireService = NetworkAlamofire(baseUrl: baseUrl)
        self.networkApi = NetworkApi(service: alamofireService)
    }

    // MARK: - Registration
    public func makeUseCaseGetHeroes() -> Domain.UseCaseHeroesDataSource {
        return UseCaseHeroesDataSource(networkApi: self.networkApi)
    }

}
