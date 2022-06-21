//
//  ReminderListViewController.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 15.06.2022.
//

import UIKit

class ReminderListViewController: UIViewController {
    
    // MARK: - Properties
    
    var authToken: String?
    let heightForRow = 70
    let rowSpacing = 15
    var remindersLimit: Int { (Int(view.frame.height) - 120) / (heightForRow + rowSpacing) }
    
    var reminders: [Reminder] = [] {
        didSet {
            updateReminders()
        }
    }
    
    // MARK: - Life cycle and override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadReminders()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if authToken == nil {
            showSignInViewController()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveReminders()
    }
    
    // MARK: - Help methods
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        title = "Birthday list"
        navigationItem.backButtonTitle = "cancel"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showEditReminderViewController))
        navigationController?.navigationBar.tintColor = accentColor
    }
    
    private func showSignInViewController() {
        let signInViewController = SignInViewController()
        signInViewController.modalPresentationStyle = .fullScreen
        signInViewController.signInCompletion = { [unowned self] email, password in
            authorize(email: email, password: password)
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
    
    private let defaults = UserDefaults.standard
    
    private func authorize(email: String, password: String) {
        authToken = "\(email) \(password)"
        defaults.set(authToken, forKey: "authToken")
    }
    
    private func loadReminders() {
        if authToken == nil {
            authToken = defaults.string(forKey: "authToken")
        }
        guard let savedData = defaults.data(forKey: "reminders") else {
            return
        }
        let decoder = JSONDecoder()
        guard let savedReminders = try? decoder.decode([Reminder].self, from: savedData) else {
            return
        }
        reminders = savedReminders
    }
    
    private func saveReminders() {
        let encoder = JSONEncoder()
        guard let savedData = try? encoder.encode(reminders) else {
            fatalError("Unable to encode reminders data.")
        }
        defaults.set(savedData, forKey: "reminders")
    }
}
