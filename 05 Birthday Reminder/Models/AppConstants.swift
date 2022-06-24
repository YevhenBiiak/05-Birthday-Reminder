//
//  AppConstants.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 22.06.2022.
//

import UIKit

let calendar: Calendar = {
    var calendar = Calendar.current
    return calendar
}()

class AppConstants {
    
    static let accentColor = #colorLiteral(red: 0.2030201852, green: 0.5886239409, blue: 0.8555393815, alpha: 1)
    static let emptyPhoto = UIImage(systemName: "person.crop.square.fill")
    
    private init() {}
}
