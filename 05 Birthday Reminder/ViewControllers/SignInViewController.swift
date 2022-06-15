//
//  SignInViewController.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 15.06.2022.
//

import UIKit

let accentColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)

class SignInViewController: UIViewController {
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
        button.addTarget(nil, action: #selector(signInButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    var signInCompletion: (() -> Void)?
    
    // MARK: - Life cycle and override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Actions
    
    @objc private func signInButtonPressed() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard !email.isEmpty, !password.isEmpty else { return }
        
        signInCompletion?()
        dismiss(animated: true)
    }
    
    // MARK: - Help methods
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        addSubviews()
        addConstraints()
        addBottomBorders()
        addShowHidePasswordToggle()
    }
    
    private func addSubviews() {
        view.addSubview(logoLabel)
        view.addSubview(signInLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(faceIdLabel)
        view.addSubview(faceIdSwitch)
        view.addSubview(signInButton)
    }
    private func addConstraints() {
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        logoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        logoLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        signInLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        signInLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 50).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 15).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 35).isActive = true
        passwordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        passwordLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        passwordLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -15).isActive = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        faceIdLabel.translatesAutoresizingMaskIntoConstraints = false
        faceIdLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50).isActive = true
        faceIdLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        
        faceIdSwitch.translatesAutoresizingMaskIntoConstraints = false
        faceIdSwitch.centerYAnchor.constraint(equalTo: faceIdLabel.centerYAnchor).isActive = true
        faceIdSwitch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.topAnchor.constraint(equalTo: faceIdLabel.bottomAnchor, constant: 50).isActive = true
        signInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        signInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func addBottomBorders() {
        view.layoutSubviews()
        emailTextField.addBottomBorder(withColor: .systemGray3, borderWidth: 2)
        passwordTextField.addBottomBorder(withColor: .systemGray3, borderWidth: 2)
    }
    
    private func addShowHidePasswordToggle() {
        passwordTextField.enablePasswordToggle(withColor: accentColor.withAlphaComponent(0.7))
    }
}
