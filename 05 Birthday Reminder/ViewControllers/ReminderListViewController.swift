//
//  ReminderListViewController.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 15.06.2022.
//

import UIKit

class ReminderListViewController: UIViewController {
    
    // MARK: - Properties
    
    let heightForRow = 70
    let rowSpacing = 15
    
    var remindersLimit: Int {
        (Int(view.frame.height) - 120) / (heightForRow + rowSpacing)
    }
    var reminders: [Reminder]? {
        didSet {
            saveData()
            updateReminders()
        }
    }
    
    // MARK: - Life cycle and override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setupViews()
    }
    
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
        signInViewController.signInCompletion = { [unowned self] in
            reminders = []
        }
        present(signInViewController, animated: true)
    }
    
    @objc func showAddReminderViewController() {
        guard reminders!.count < remindersLimit else {
            reminders = []
            return
        }
        
//        let birthday = Calendar.current.date(from: DateComponents(year: 1994, month: 9, day: 27))!
//        let person = Person(photo: nil, name: "Jhon", age: 27, birthDate: birthday, gender: "male", instagram: "cdd3")
//        let reminder = Reminder(person: person)
//        reminders?.append(reminder)
        
        let addReminderViewController = AddReminderViewController()
//        addReminderViewController.modalPresentationStyle = .popover
//        addReminderViewController.addCompletion = { [unowned self] person in
//            let reminder = Reminder(person: person)
//            reminders?.append(reminder)
//        }
        present(addReminderViewController, animated: true)
    }
    
    // MARK: - Help methods
    
    private func setupViews() {
        title = "Birthday list"
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddReminderViewController))
        navigationItem.rightBarButtonItem?.tintColor = accentColor
    }
    
    private func updateReminders() {
        view.subviews.forEach { $0.removeFromSuperview() }

        for (index, reminder) in reminders!.enumerated() {
            let origin = CGPoint(x: 8, y: 120 + index * (heightForRow + rowSpacing))
            let size = CGSize(width: view.frame.width - 16.0, height: CGFloat(heightForRow))
            
            let reminderView = ReminderView(frame: CGRect(origin: origin, size: size))
            reminderView.reminder = reminder
            
            view.addSubview(reminderView)
        }
    }
    
    // MARK: - Storage methods
    
    private func loadData() {
        let defaults = UserDefaults.standard
        guard let savedData = defaults.data(forKey: "reminders") else {
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
