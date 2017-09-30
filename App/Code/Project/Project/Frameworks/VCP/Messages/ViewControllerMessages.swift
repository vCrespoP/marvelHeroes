//
//  ViewControllerMessages.swift

import Foundation

import Whisper

public protocol ViewControllerMessages: MessagesProtocol {}

public extension ViewControllerMessages where Self: UIViewController {

    public func localized(_ string: String) -> String {
        return NSLocalizedString(string, comment: "")
    }

    // MARK: Colors
    public func textColor(for type: MessageNotificationType) -> UIColor {

        var notificationColor = UIColor.white

        switch type {
        case .error:
            notificationColor = UIColor.white
        case .success:
            notificationColor = UIColor.white
        case .warning:
            notificationColor = UIColor.black
        case .info:
            notificationColor = UIColor.black
        }

        return notificationColor
    }

    public func backgroundColor(for type: MessageNotificationType) -> UIColor {

        var notificationColor = UIColor.white

        switch type {
        case .error:
            notificationColor = UIColor.red
        case .success:
            notificationColor = UIColor (red: 0.0002, green: 0.644, blue: 0.0, alpha: 1.0)
        case .warning:
            notificationColor = UIColor (red: 0.8429, green: 0.664, blue: 0.1399, alpha: 1.0)
        case .info:
            notificationColor = UIColor.white
        }

        return notificationColor
    }

    // MARK: Dialogs
    public func showMessage(title: String?, type: MessageNotificationType) {

        guard let navigationController = self.navigationController else {
            showNotification(title: title, subtitle: nil, image: nil, type: type)
            return
        }

        if title == nil || title?.characters.count == 0 {
            print("Default Implementation Messages: No title")
            return
        }

        let bgColor = self.backgroundColor(for: type)
        let textColor = self.textColor(for: type)

        var message = Whisper.Message(title: title!, textColor: textColor)
        message.backgroundColor = bgColor
        DispatchQueue.main.async {
            Whisper.show(whisper: message, to: navigationController)
        }
    }

    public func showNotification(title: String?, subtitle: String?, image: UIImage?, type: MessageNotificationType) {

        guard let title = title else {
            print("Default Implementation Messages: No title")
            return
        }

        let announcement = Announcement(title: title, subtitle: subtitle, image: image)
        DispatchQueue.main.async {
            Whisper.show(shout: announcement, to: self.navigationController ?? self)
        }

    }

    public func showStatusBarMessage(title: String?, type: MessageNotificationType) {
        guard let title = title else {
            print("Default Implementation Messages: No title")
            return
        }

        let bgColor = backgroundColor(for: type)
        let txtColor = textColor(for: type)

        let message = Murmur(title: title, backgroundColor: bgColor, titleColor: txtColor, font: FontList.Whistle.title)

        DispatchQueue.main.async {
            Whisper.show(whistle: message)
        }
    }

    public func showAlertController(message: Message, actions: [MessageAction], style: UIAlertControllerStyle = .alert, source: MessageSource? = nil, setup: ((UIAlertController) -> Void)? = nil) {
        let alertController = UIAlertController(title: message.title, message: message.text, preferredStyle: style)
        for action in actions {
            alertController.addAction(localizedAction(action))
        }

        switch source {
        case .some(.view(let view, let frame)):
            alertController.popoverPresentationController?.sourceView = view
            alertController.popoverPresentationController?.sourceRect = frame
        case .some(.barButtonItem(let item)):
            alertController.popoverPresentationController?.barButtonItem = item
        case nil:
            break
        }

        setup?(alertController)

        self.present(alertController, animated: true, completion: nil)
    }

    public func localizedAction(_ action: MessageAction) -> UIAlertAction {
        var localizedAction = action
        localizedAction.title = action.title.map { self.localized($0) }
        return localizedAction.alertAction
    }

    public func showInformation(message: Message, accept: MessageAction = MessageAction.ok) {
        showAlertController(message: message, actions: [accept])
    }

    public func showConfirmation(message: Message, accept: MessageAction = MessageAction.ok, cancel: MessageAction = MessageAction.cancel) {
        showAlertController(message: message, actions: [accept, cancel])
    }

    public func showAlertTextField(message: Message, fieldPlaceHolder: String?, fieldText: String?, accept: TextFieldMessageAction = TextFieldMessageAction.ok, cancel: MessageAction = MessageAction.cancel) {

        let alertController = UIAlertController(title: message.title, message: message.text, preferredStyle: .alert)

        let actionAccept = MessageAction(title: accept.title, style: accept.style, handler: {
            let firstTextField = alertController.textFields?[0]
            accept.handler(firstTextField?.text)
        })

        alertController.addTextField { textField in
            textField.placeholder = fieldPlaceHolder
            textField.text = fieldText
        }

        alertController.addAction(localizedAction(actionAccept))
        alertController.addAction(localizedAction(cancel))

        self.present(alertController, animated: true, completion: nil)
    }

    // TODO: Fix this for iPad
    public func showActionSheet(message: Message, options: [MessageAction], source: MessageSource) {
        showAlertController(message: message, actions: options, style: .actionSheet, source: source)
    }
}

