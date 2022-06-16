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
    let age: UInt
    let birthDate: Date
    let sex: String
    let instagram: String
    
    init(photo: UIImage?, name: String, age: UInt, birthDate: Date, sex: String, instagram: String) {
        self.photo = photo?.pngData()
        self.name = name
        self.age = age
        self.birthDate = birthDate
        self.sex = sex
        self.instagram = instagram
    }
}
