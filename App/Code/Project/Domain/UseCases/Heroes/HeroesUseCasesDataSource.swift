//
//  UseCaseProvider.swift

import Foundation

import RxSwift

//
// MARK: - Registration
//

public protocol UseCaseHeroesDataSource {

    func getHeroes() -> Observable<SuccessResponse<Heroes>>

}

