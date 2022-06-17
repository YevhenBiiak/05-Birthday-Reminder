//
//  UITextFieldExtensions.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 15.06.2022.
//

import UIKit

private let showHidePasswordButton: UIButton = {
    var config = UIButton.Configuration.plain()
    config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: UIImage.SymbolScale.medium)
    config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
    config.image = UIImage(systemName: "eye")
    let button = UIButton(configuration: config)
    return button
}()

extension UITextField {
    func enablePasswordToggle(withColor color: UIColor? = nil) {
        showHidePasswordButton.addTarget(nil, action: #selector(togglePasswordView), for: .touchUpInside)
        showHidePasswordButton.tintColor = color
        rightView = showHidePasswordButton
        rightViewMode = .always
        isSecureTextEntry = true
    }
    
    @objc private func togglePasswordView(_ sender: Any) {
        isSecureTextEntry.toggle()
        if isSecureTextEntry {
            showHidePasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            showHidePasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
}
