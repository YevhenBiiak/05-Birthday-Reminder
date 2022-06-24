//
//  Reminder.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 15.06.2022.
//

import UIKit

struct Reminder: Codable {
    let person: Person
    
    var day: Int {
        calendar.component(.day, from: person.birthDate)
    }
    
    var month: String {
        calendar.monthSymbols[calendar.component(.month, from: person.birthDate) - 1]
    }
    
    var nextBirthday: Date {
        calendar.date(byAdding: .year, value: person.age + 1, to: person.birthDate)!
    }
    
    var daysLeft: Int {
        let days = calendar.dateComponents([.day], from: calendar.startOfDay(for: Date.now), to: nextBirthday).day
        return days!
    }
    
    var weekday: String {
        calendar.weekdaySymbols[calendar.component(.weekday, from: nextBirthday)-1]
    }
    
    init(person: Person) {
        self.person = person
    }
}
