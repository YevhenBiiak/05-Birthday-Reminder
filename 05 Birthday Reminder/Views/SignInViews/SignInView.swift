//
//  SignInView.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 19.06.2022.
//

import UIKit

class SignInView: UIView {
    let logoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "Birthday Reminder"
        return label
    }()
    
    let signInLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        label.text = "Sign In"
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = accentColor
        label.text = "Email"
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.placeholder = "Enter email"
        return textField
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.textColor = accentColor
        label.text = "Password"
        return label
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter password"
        return textField
    }()
    
    let faceIdLabel: UILabel = {
        let label = UILabel()
        label.text = "Enable FaceId authorization"
        return label
    }()
    
    let faceIdSwitch: UISwitch = {
        UISwitch()
    }()
    
    let signInButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = accentColor
        config.title = "Sign In"
        config.baseForegroundColor = .white
        let button = UIButton(configuration: config)
        return button
    }()
    
    // MARK: - Initializators and overide methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBottomBorders()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Help methods
    
    private func setupViews() {
        backgroundColor = .systemBackground
        addSubviews()
        addConstraints()
        addShowHidePasswordToggle()
    }
    
    private func addSubviews() {
        addSubview(logoLabel)
        addSubview(signInLabel)
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(faceIdLabel)
        addSubview(faceIdSwitch)
        addSubview(signInButton)
    }
    
    private func addConstraints() {
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        faceIdLabel.translatesAutoresizingMaskIntoConstraints = false
        faceIdSwitch.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints(H: "|-50-[logoLabel]-50-|", V: "|-70-[logoLabel]")
        addConstraints(H: "|-40-[signInLabel]-40-|", V: "[logoLabel]->=70-[signInLabel]")
        addConstraints(H: "|-40-[emailLabel]-40-|", V: "[signInLabel]-30-[emailLabel]")
        addConstraints(H: "|-40-[emailTextField]-40-|", V: "[emailLabel]-8-[emailTextField(44)]")
        addConstraints(H: "|-40-[passwordLabel]-40-|", V: "[emailTextField]-30-[passwordLabel]")
        addConstraints(H: "|-40-[passwordTextField]-40-|", V: "[passwordLabel]-8-[passwordTextField(44)]")
        addConstraints(H: "|-40-[faceIdLabel]-[faceIdSwitch]-40-|", V: "[passwordTextField]-30-[faceIdLabel]")
        addConstraints(V: "[passwordTextField]-30-[faceIdSwitch]")
        addConstraints(H: "|-40-[signInButton]-40-|", V: "[faceIdSwitch]-30-[signInButton(44)]-<=300-|")
    }
    
    private func addBottomBorders() {
        emailTextField.addBorder(to: .bottom, color: .systemGray3, width: 1)
        passwordTextField.addBorder(to: .bottom, color: .systemGray3, width: 1)
    }
    
    private func addShowHidePasswordToggle() {
        passwordTextField.enablePasswordToggle(withColor: accentColor.withAlphaComponent(0.7))
    }
}
