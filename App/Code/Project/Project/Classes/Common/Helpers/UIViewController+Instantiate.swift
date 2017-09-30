/******************************************************************************
 *
 *
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 Vicente Crespo  All rights reserved.
 *
 ******************************************************************************/

import Foundation

extension UIImageView {

    func setImageWithUrl(imageUrl: String?) {

        if !imageUrl.isNilOrEmpty {
            self.setImageWithURL(NSURL(string: imageUrl!), usingActivityIndicatorStyle: .Gray)
        } else {
            self.hideByHeight(true)
            self.hideByWidth(true)
        }

    }

    func setIconWithUrl(iconUrl: String?) {
        setIconWithUrl(iconUrl, tintColor: nil)
    }

    func setIconWithUrl(iconUrl: String?, tintColor: UIColor?) {

        if let iconUrl = iconUrl {
            let iconUrlWithScale = iconUrl + scaleForIcon()
            setImageWithURL(NSURL(string: iconUrlWithScale),
                            completed: { (image, _, _, _) -> Void in
                                if let tintColor = tintColor, image = image {
                                    self.image = image.tintWithColor(tintColor)
                                }
            },
                            usingActivityIndicatorStyle: .Gray)
        }

    }

    // MARK: Private
    private func scaleForIcon() -> String {
        let scale = VCFHelperDevice.deviceScale()
        return "\(scale)"
    }

}
