//
//  AuthTextField.swift
//  my-first-app
//
//  Created by pinpinpin on 1/11/2568 BE.
//
import UIKit
import SnapKit

final class AuthTextField: UITextField {
    init(placeholder: String, keyboardType: UIKeyboardType, isSecure: Bool) {
        super.init(frame: .zero)
        borderStyle = .none
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.separator.cgColor
        backgroundColor = .secondarySystemBackground
        textColor = .label
        font = .systemFont(ofSize: 16)
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.isSecureTextEntry = isSecure

        let pad = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 10))
        leftView = pad
        leftViewMode = .always

        snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(44)
        }
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
