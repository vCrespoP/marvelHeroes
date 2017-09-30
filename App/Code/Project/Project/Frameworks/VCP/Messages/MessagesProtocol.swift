//
//  MessagesProtocol.swift

import Foundation
import UIKit

public enum MessageNotificationType {
    case success
    case warning
    case error
    case info
}

public struct Message {
    public var title: String?
    public var text: String?

    public init(title: String?, text: String? = nil) {
        self.title = title
        self.text = text
    }
}

/// This is necessary because UIAlertAction doesn't allow to change the title, you can't access the handler, …
public struct MessageAction {
    public typealias MessageHandler = () -> Void

    public var title: String?
    public var style: UIAlertActionStyle = UIAlertActionStyle.default
    public var handler: MessageHandler

    public init(title: String?, style: UIAlertActionStyle = UIAlertActionStyle.default, handler: @escaping MessageHandler = {}) {
        self.title = title
        self.style = style
        self.handler = handler
    }
}

// MARK: Get Alert Action
public extension MessageAction {
    public var alertAction: UIAlertAction {
        return UIAlertAction(title: self.title, style: self.style, handler: { _ in self.handler() })
    }
}

public struct TextFieldMessageAction {
    public var title: String?
    public var style: UIAlertActionStyle = .default
    public var handler: (String?) -> Void

    public init(title: String?, style: UIAlertActionStyle = UIAlertActionStyle.default, handler: @escaping (String?) -> Void) {
        self.title = title
        self.style = style
        self.handler = handler
    }
}

public extension TextFieldMessageAction {
    public static var ok: TextFieldMessageAction {
        return TextFieldMessageAction(title: "Ok", style: .default, handler: { _ in })
    }
}

public enum MessageSource {
    case view(UIView, rect: CGRect)
    case barButtonItem(UIBarButtonItem)
}

// MARK: Common actions
public extension MessageAction {
    public static var ok: MessageAction {
        return MessageAction(title: "Ok", style: .cancel, handler: { })
    }

    public static var cancel: MessageAction {
        return MessageAction(title: "Cancel", style: .cancel, handler: { })
    }
}

public typealias EmptyAction = () -> Void

public typealias InformationAcceptHandler    = EmptyAction
public typealias ConfirmationAcceptHandler   = EmptyAction
public typealias ConfirmationCancelHandler   = EmptyAction
public typealias TextFieldAcceptHandler      = (String?) -> Void
public typealias TextFieldCancelHandler      = EmptyAction
public typealias ActionSheetCancelHandler    = EmptyAction

public protocol MessagesProtocol {

    func localized(_ string: String) -> String

    // MARK: Colors
    func textColor(for type: MessageNotificationType) -> UIColor
    func backgroundColor(for type: MessageNotificationType) -> UIColor

    // MARK: Dialogs
    func showMessage(title: String?, type: MessageNotificationType)
    func showStatusBarMessage(title: String?, type: MessageNotificationType)

    func showNotification(title: String?, subtitle: String?, image: UIImage?, type: MessageNotificationType)

    func showInformation(message: Message, accept: MessageAction)

    func showConfirmation(message: Message, accept: MessageAction, cancel: MessageAction)

    func showAlertTextField(message: Message, fieldPlaceHolder: String?, fieldText: String?, accept: TextFieldMessageAction, cancel: MessageAction)

    func showActionSheet(message: Message, options: [MessageAction], source: MessageSource)
}

