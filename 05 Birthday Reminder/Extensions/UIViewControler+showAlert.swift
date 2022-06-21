//
//  UIViewControler+showAlert.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 20.06.2022.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}
