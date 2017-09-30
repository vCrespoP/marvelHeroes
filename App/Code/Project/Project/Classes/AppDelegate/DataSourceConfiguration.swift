//
//  DataSourceConfiguration.swift

import Foundation

import Domain

import RxSwift

import PlatformNetworkApi
import PlatformNetworkStatic

enum DataSourceType {
    case getHeroes
}

class DataSourceConfiguration {

    fileprivate var dataSourceProviderNetworkApi: Domain.UseCaseDataSourceProvider {
        return PlatformNetworkApi.UseCaseDataSourceProvider(environment: .integration)
    }

    fileprivate var dataSourceProviderNetworkStaticSuccess: Domain.UseCaseDataSourceProvider {
        return PlatformNetworkStatic.UseCaseDataSourceProvider(responseType: ResponseType.success(code: 200), delay: 2)
    }

    fileprivate var dataSourceProviderNetworkStaticError: Domain.UseCaseDataSourceProvider {
        return PlatformNetworkStatic.UseCaseDataSourceProvider(responseType: ResponseType.error(code: 500), delay: 2)
    }

    fileprivate var dataSourceProviderNetworkStaticTimeOut: Domain.UseCaseDataSourceProvider {
        return PlatformNetworkStatic.UseCaseDataSourceProvider(responseType: ResponseType.timeout(seconds: 1), delay: 2)
    }

    func getType(for type: DataSourceType) -> Domain.UseCaseDataSourceProvider {
        switch type {
        case .getHeroes:
            return self.dataSourceProviderNetworkApi
        }
    }

}

