//
//  TextField Delegate.swift
//

import UIKit

internal class TextFieldDelegate: NSObject, UITextFieldDelegate {

    static var AssociatedObjectKey: Void?

    init(alertController controller: UIAlertController, isValid: @escaping TextCollector.Validator) {
        self.controller = controller
        self.isValid = isValid
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString: String) -> Bool {
        let originalString = textField.text!
        let newString = originalString.replacingCharacters(in: Range(range, in: originalString)!, with: replacementString)

        controller!.preferredAction?.isEnabled = controller!.textFields!.allSatisfy { otherTextField in
            if otherTextField === textField {
                return isValid(newString)
            } else {
                return (otherTextField.delegate?.textFieldShouldReturn?(otherTextField)) ?? true
            }
        }

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            return isValid(text)
        } else {
            return false
        }
    }

    private weak var controller: UIAlertController?
    private let isValid: TextCollector.Validator

}
