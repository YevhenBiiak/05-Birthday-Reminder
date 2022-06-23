//
//  ReminderListViewController.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 15.06.2022.
//

import UIKit

class ReminderListViewController: UIViewController {
    
    // MARK: - Properties
    
    private var authToken: String?
    private let storage = ReminderStorage()
    private let heightForRow = 70
    private let rowSpacing = 15
    private var remindersLimit: Int { (Int(view.frame.height) - 120) / (heightForRow + rowSpacing) }
    
    var reminders: [Reminder] = [] {
        didSet {
            updateReminders()
            saveReminders()
        }
    }
    
    // MARK: - Life cycle and override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signIn()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if authToken == nil {
            showSignInViewController()
        }
    }
    
    // MARK: - Help methods
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        title = "Birthday list"
        navigationItem.backButtonTitle = "cancel"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showEditReminderViewController))
        navigationController?.navigationBar.tintColor = AppConstants.accentColor
    }
    
    private func showSignInViewController() {
        let signInViewController = SignInViewController()
        signInViewController.modalPresentationStyle = .fullScreen
        signInViewController.signInCompletion = { [unowned self] email, password in
            sighUp(email: email, password: password)
        }
        present(signInViewController, animated: true)
    }
    
    @objc private func showEditReminderViewController() {
        guard reminders.count < remindersLimit else {
            showAlert(title: "Sorry", message: "Limit of reminders is \(remindersLimit)")
            return
        }
        
        let editReminderViewController = EditReminderViewController()
        editReminderViewController.editReminderCompletion = { [unowned self] person in
            let reminder = Reminder(person: person)
            reminders.append(reminder)
        }
        navigationController?.pushViewController(editReminderViewController, animated: true)
    }
    
    private func updateReminders() {
        view.subviews.forEach { $0.removeFromSuperview() }

        for (index, reminder) in reminders.enumerated() {
            let origin = CGPoint(x: 8, y: 120 + index * (heightForRow + rowSpacing))
            let size = CGSize(width: view.frame.width - 16.0, height: CGFloat(heightForRow))
            
            let reminderView = ReminderView(frame: CGRect(origin: origin, size: size))
            reminderView.tag = index
            reminderView.reminder = reminder
            
            view.addSubview(reminderView)
        }
    }
    
    // MARK: - Storage methods
    
    private func signIn() {
        authToken = storage.signIn()
        if authToken != nil {
            loadReminders()
        }
    }
    
    private func sighUp(email: String, password: String) {
        authToken = storage.signUp(email: email, password: password)
    }
    
    private func loadReminders() {
        reminders = storage.load()
    }
    
    private func saveReminders() {
        storage.save(reminders: reminders)
    }
}
