//
//  RatioImageView.swift
//

import UIKit

public class RatioImageView: UIImageView {

    public var constraint: NSLayoutConstraint?

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateConstraint()
    }

    public override init(image: UIImage?) {
        super.init(image: image)
        updateConstraint()
    }

    public override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        updateConstraint()
    }

    public override var image: UIImage? {
        didSet {
            updateConstraint()
        }
    }

    private func updateConstraint() {
        if let constraint = self.constraint {
            constraint.isActive = false
            self.removeConstraint(constraint)
        }

        if let image = self.image, image.size.height > 0.0 {
            let ratio = image.size.width / image.size.height
            self.constraint = self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: ratio)
            self.constraint!.isActive = true
        }
    }

}
