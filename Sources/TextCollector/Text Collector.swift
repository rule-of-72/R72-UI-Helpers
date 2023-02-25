//
//  Text Collector.swift
//

import UIKit

public class TextCollector {

    // MARK: - Public Types

    public typealias Validator = (String) -> Bool

    public typealias Results = [String?]
    public enum Result {
        case ok(Results)
        case canceled
    }

    public typealias Completion = (Result) -> Void

    // MARK: - Private types

    private struct Field {
        let originalText:       String?
        let placeholderText:    String?
        let secure:             Bool
        let validator:          Validator?
    }

    // MARK: - Public methods

    public init() { }

    public func show(title: String?, message: String?, hostingViewController viewController: UIViewController, sourceView view: UIView? = nil, completion: @escaping Completion) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(.canceled)
        }

        alert.addAction(cancelAction)

        let okAction = UIAlertAction(title: "OK", style: .default) { [weak alert] _ in
            let results: Results = alert?.textFields?.map { $0.text } ?? []
            completion(.ok(results))
        }

        alert.addAction(okAction)
        alert.preferredAction = okAction

        for field in fields {
            alert.addTextField { textField in
                textField.text = field.originalText
                textField.placeholder = field.placeholderText
                textField.textAlignment = .left
                textField.returnKeyType = .default
                textField.isSecureTextEntry = field.secure

                let delegate = TextFieldDelegate(alertController: alert, isValid: field.validator ?? Self.defaultValidator(_:))
                textField.delegate = delegate

                objc_setAssociatedObject(textField, &TextFieldDelegate.AssociatedObjectKey, delegate, .OBJC_ASSOCIATION_RETAIN)
            }
        }

        okAction.isEnabled = alert.textFields?.allSatisfy { textField in
            (textField.delegate?.textFieldShouldReturn?(textField)) ?? true
        } ?? true

        if let popPC = alert.popoverPresentationController {
            popPC.sourceView = view ?? viewController.view
            popPC.sourceRect = popPC.sourceView!.bounds
        }

        viewController.present(alert, animated: true, completion: nil)
    }

    public func addField(originalText: String? = nil, placeholderText: String? = nil, secure: Bool = false, validator: Validator? = nil) {
        fields.append(Field(originalText: originalText, placeholderText: placeholderText, secure: secure, validator: validator))
    }

    // MARK: - Private methods

    private static func defaultValidator(_: String) -> Bool {
        return true
    }

    // MARK: - Properties

    private var fields: [Field] = []

}
