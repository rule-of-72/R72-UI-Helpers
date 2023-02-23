//
//  AutoFadeLabel.swift
//

import UIKit


fileprivate let blank = " "


public class AutoFadeLabel: UILabel {

    public override var text: String? {
        didSet {
            if text != nil {
                alpha = 1.0

                UIView.animate(
                    withDuration: duration,
                    animations: { [weak self] in
                        guard let self = self else { return }
                        self.alpha = 0.0
                    },
                    completion: { [weak self] completed in
                        guard let self = self, completed else { return }
                        self.text = blank
                    }
                )
            } else {
                alpha = 0.0
            }
        }
    }

    @IBInspectable
    public var duration: CGFloat = 0.0

}
