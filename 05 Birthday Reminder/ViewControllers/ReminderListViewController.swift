//
//  ReminderListViewController.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 15.06.2022.
//

import UIKit

class ReminderListViewController: UIViewController {
    
    // MARK: - Properties
    
    var reminders: [Reminder]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    // MARK: - Life cycle override methods
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if reminders == nil {
            showSignInViewController()
        }
    }
    
    // MARK: - Actions
    
    func showSignInViewController() {
        let signInViewController = SignInViewController()
        signInViewController.modalPresentationStyle = .fullScreen
        signInViewController.signInCompletion = { 
            self.reminders = []
        }
        present(signInViewController, animated: true)
    }
    
    // MARK: - Help methods
    
    private func loadData() {
        let defaults = UserDefaults.standard
        guard let savedData = defaults.data(forKey: "reminders") else {
            reminders = nil
            return
        }
        let decoder = JSONDecoder()
        guard let savedReminders = try? decoder.decode([Reminder].self, from: savedData) else {
            return
        }
        reminders = savedReminders
    }
    
    private func saveData() {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        guard let savedData = try? encoder.encode(reminders) else {
            fatalError("Unable to encode reminders data.")
        }
        defaults.set(savedData, forKey: "reminders")
    }
}
