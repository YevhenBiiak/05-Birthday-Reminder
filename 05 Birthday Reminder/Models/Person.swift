//
//  Person.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 15.06.2022.
//

import UIKit

struct Person: Codable {
    var photo: Data?
    let name: String
    let age: Int
    let birthDate: Date
    let gender: String
    let instagram: String?
    
    init(photo: UIImage?, name: String, age: Int, birthDate: Date, gender: String, instagram: String?) {
        self.photo = photo?.pngData()
        self.name = name
        self.age = age
        self.birthDate = birthDate
        self.gender = gender
        self.instagram = instagram
    }
    
    enum Gender: String, CaseIterable {
        case male
        case female
    }
}
