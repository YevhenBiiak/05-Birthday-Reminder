//
//  Reminder.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 15.06.2022.
//

import UIKit

struct Reminder: Codable {
    let person: Person
    let dayOfBirth: Int
    let monthOfBirth: String
    let daysLeftToTheNextBirthday: Int
    let dayOfWeekForTheNextBirthday: String
    
    init(person: Person) {
        self.person = person
        let calendar = Calendar.current
        let nextBirthday = calendar.date(byAdding: .year, value: Int(person.age) + 1, to: person.birthDate)!
        self.dayOfBirth = calendar.component(.day, from: person.birthDate)
        self.monthOfBirth = calendar.monthSymbols[calendar.component(.month, from: person.birthDate)]
        self.daysLeftToTheNextBirthday = Int(nextBirthday.timeIntervalSinceNow / ( 3600 * 24 ))
        self.dayOfWeekForTheNextBirthday = calendar.weekdaySymbols[calendar.component(.weekday, from: nextBirthday)]
    }
}
