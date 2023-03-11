//
//  QRCodeView.swift
//

import UIKit
import QRSwift

@IBDesignable
public class QRCodeView: UIView {

    @IBInspectable
    public var message: String = "" {
        didSet {
            regenerateImage()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpImageView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpImageView()
    }

    private func regenerateImage() {
        let image = message.data(using: .ascii, allowLossyConversion: false)
            .flatMap { generator.image(with: $0, outputImageSize: imageView.bounds.size) }
            .flatMap { UIImage(ciImage: $0) }
        imageView.image = image
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        regenerateImage()
    }

    private func setUpImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        addSubview(imageView)

        [
            NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0),
        ].forEach {
            $0.isActive = true
        }
    }

    private let imageView = UIImageView()
    private let generator = QRCodeGenerator()

}
