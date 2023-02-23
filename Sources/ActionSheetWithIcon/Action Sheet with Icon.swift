//
//  Action Sheet with Icon.swift
//

import UIKit

public extension UIAlertAction {

    convenience init(title: String, icon: UIImage?, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)?) {
        self.init(title: title, style: style, handler: handler)

        if let icon = icon {
            self.setValue(icon, forKey: "image")
        }
    }

    convenience init(title: String, systemImageName: String, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)?) {
        self.init(title: title, style: style, handler: handler)

        if let icon = UIImage(systemName: systemImageName) {
            self.setValue(icon, forKey: "image")
        }
    }

}
