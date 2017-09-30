//
//  TRNStateController.swift

import Foundation

protocol StateController {

    //
    // MARK: Properties
    //
    var loadingView: StatefulViewProtocol? { get set }
    var errorView: StatefulViewProtocol? { get set }
    var infoView: StatefulViewProtocol? { get set }

    //
    // MARK: Event handling
    //
    func showErrorWithContent(_ error: Error)

    // MARK: View Handling
    func showOriginalView()
    func showLoadingView(statefulViewModel: StatefulViewModel)
    func showErrorView(statefulViewModel: StatefulViewModel)
    func showInfoView(statefulViewModel: StatefulViewModel)

}

