//
//  ReminderStorage.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 23.06.2022.
//

import Foundation

protocol ReminderStorageProtocol {
    func load() -> [Reminder]
    func save(reminders: [Reminder])
}

class ReminderStorage: ReminderStorageProtocol {
    private let authDataFile = "authData.plist"
    private let remindersFile = "Reminders.txt"
    private let tempDirURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    
    func signIn() -> String? {
        let authDataPathURL = tempDirURL.appendingPathComponent(authDataFile)
        guard FileManager.default.fileExists(atPath: authDataPathURL.path) else {
            return nil
        }
        if let authData = try? NSDictionary(contentsOf: authDataPathURL, error: ()) {
            return "\(authData["email"]!) \(authData["password"]!)"
        }
        return nil
    }
    
    func signUp(email: String, password: String) -> String {
        let authData = NSDictionary(dictionary: ["email": email, "password": password])
        let authDataPathURL = tempDirURL.appendingPathComponent(authDataFile)
        
        authData.write(to: authDataPathURL, atomically: true)
        
        let authToken = "\(email) \(password)"
        return authToken
    }
    
    func load() -> [Reminder] {
        let fileNamePathURL = tempDirURL.appendingPathComponent(remindersFile)
        guard FileManager.default.fileExists(atPath: fileNamePathURL.path) else {
            return []
        }
        do {
            let savedData = try Data(contentsOf: fileNamePathURL)
            let savedReminders = try JSONDecoder().decode([Reminder].self, from: savedData)
            return savedReminders
        } catch {
            print("load", error)
        }
        return []
    }
    
    func save(reminders: [Reminder]) {
        let fileNamePathURL = tempDirURL.appendingPathComponent(remindersFile)
        do {
            let savedData = try JSONEncoder().encode(reminders)
            try savedData.write(to: fileNamePathURL)
        } catch {
            print("save", error)
        }
    }
}
