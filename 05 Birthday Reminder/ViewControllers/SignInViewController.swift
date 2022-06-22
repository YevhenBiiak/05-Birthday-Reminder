//
//  SignInViewController.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 15.06.2022.
//

import UIKit

class SignInViewController: UIViewController {
    
    private var signInView: SignInView!
    var signInCompletion: ((String, String) -> Void)?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignInView()
        addKeyboardObservers()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    deinit {
        removeKeyboardObservers()
    }
    
    // MARK: - Help methods with actions
    
    private func setupSignInView() {
        signInView = SignInView(frame: view.frame)
        view.addSubview(signInView)
        signInView.signInButton.addTarget(nil, action: #selector(signInButtonPressed), for: .touchUpInside)
    }
    
    @objc private func signInButtonPressed() {
        guard let email = signInView.emailTextField.text, !email.isEmpty else {
            showAlert(title: "Oops!", message: "Еnter your email")
            return
        }
        guard let password = signInView.passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Oops!", message: " Password field is empty")
            return
        }

        signInCompletion?(email, password)
        dismiss(animated: true)
    }
}

extension SignInViewController {
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateViews(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateViews(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func updateViews(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any],
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        let bottomHeight = view.frame.height - signInView.signInButton.frame.origin.y + signInView.signInButton.frame.height - 100
        if bottomHeight < keyboardFrame.height {
            if notification.name == UIResponder.keyboardWillShowNotification {
                view.frame.origin.y = -(keyboardFrame.height - bottomHeight)
            } else {
                view.frame.origin.y = 0
            }
        }
    }
}
