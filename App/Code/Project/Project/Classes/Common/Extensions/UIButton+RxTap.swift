//
//  UIButton+RxTap.swift

import Foundation
import UIKit

import RxSwift
import RxCocoa

extension UIButton {

    func observableTap(timeSpan: Double = 1, count: Int = 10000) -> Observable<Void> {
        // In 'timespan' seconds, just one tap, unless user taps 10000 times to trigger another tap action
        let result = self
            .rx
            .tap
            .window(timeSpan: timeSpan, count: count, scheduler: MainScheduler.instance)
            .flatMap { observable in
                return observable.take(1)
        }

        return result

    }

    typealias RxTapHandler = () -> Void
    func rxTap(timeSpan: Double = 1, count: Int = 10000, operation: @escaping RxTapHandler = {}) -> Disposable {

        let observable = observableTap(timeSpan: timeSpan, count: count)

        return observable.subscribe(onNext: {
            operation()
        })

    }

}
