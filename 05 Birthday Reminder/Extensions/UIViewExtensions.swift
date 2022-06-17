//
//  UIViewExtensions.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 15.06.2022.
//

import UIKit

extension UIView {
    
    enum BorderType { case top, left, right, bottom }
    func addBorder(at type: BorderType, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        switch type {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        case .right:
            border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        case .bottom:
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        }
        self.layer.addSublayer(border)
    }
    
    // Visual formatting langauge
    func addConstraints(target: AnyObject, H: String = "", V: String = "") {
        let format = ["H:" + H, "V:" + V]
        var usedViewNames: Set<String> = []
        format.forEach { one in
            let separated = one.split(separator: "[")
            let filtered = separated.filter { $0.contains("]") }
            let cleaned = filtered.map { String($0.split(separator: "]").first!.split(separator: "(").first!) }
            cleaned.forEach { usedViewNames.insert($0) }
        }
        var views: [String: Any] = [:]
        let childrens = Mirror(reflecting: target).children
        for children in childrens {
            if Array(usedViewNames).contains(children.label) {
                views[children.label!] = children.value
            }
        }
        format.forEach {
            NSLayoutConstraint.activate(
                Array(NSLayoutConstraint.constraints(withVisualFormat: $0, metrics: nil, views: views)))
        }
    }
}
