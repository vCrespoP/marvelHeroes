//
//  UITextField+RxText.swift

import Foundation
import UIKit

import RxSwift
import RxCocoa

extension UITextField {

    typealias RxTextHandler = (_ text: String?) -> Void
    func rxText(skipElements: Int = 1, operation: @escaping RxTextHandler = { _ in }) -> Disposable {
        let observable = self.rx
            .text
            .skip(skipElements)

        return observable.subscribe(onNext: {
            operation($0)
        })
    }

    typealias RxDoneHandler = () -> Void
    func rxDone(operation: @escaping RxDoneHandler = {  }) -> Disposable {
        let observable = self.rx
            .controlEvent(.editingDidEndOnExit)

        return observable.subscribe(onNext: { _ in
            operation()
        })
    }

}
