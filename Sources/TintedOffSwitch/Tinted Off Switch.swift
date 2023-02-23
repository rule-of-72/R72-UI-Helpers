//
//  Tinted Off Switch.swift
//

import UIKit

@IBDesignable
public class TintedOffSwitch: UISwitch {

    @IBInspectable
    public var offTintColor: UIColor? {
        didSet {
            updateOff()
        }
    }

    public override var bounds: CGRect {
        didSet {
            updateOff()
        }
    }

    private func updateOff() {
        if let offTintColor = offTintColor {
            let minSide = min(bounds.size.height, bounds.size.width)
            layer.cornerRadius = minSide / 2
            backgroundColor = offTintColor
            tintColor = offTintColor
        } else {
            backgroundColor = .clear
            layer.cornerRadius = 0
        }

    }

}
