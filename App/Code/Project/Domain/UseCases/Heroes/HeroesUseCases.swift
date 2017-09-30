//
//  RegistrationUseCases+Default.swift

import Foundation

import RxSwift

public enum HeroesUseCase {

    public static func heroes(dataSource: UseCaseHeroesDataSource) -> Observable<SuccessResponse<Heroes>> {
        // Do any additional logic / validation if needed
        return dataSource.getHeroes()
    }

}

