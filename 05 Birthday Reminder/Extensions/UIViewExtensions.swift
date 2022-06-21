//
//  UIViewExtensions.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 15.06.2022.
//

import UIKit

extension UIView {
    enum BorderType { case top, left, right, bottom }
    func addBorder(to type: BorderType, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        switch type {
            case .top: border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
            case .left: border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
            case .right: border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
            case .bottom: border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        }
        self.layer.addSublayer(border)
    }
    
    // Visual formatting langauge
    func addConstraints(H: String = "", V: String = "") {
        var views: [String: UIView] = [:]
        Mirror(reflecting: self).children.forEach {
            if let label = $0.label, let view = $0.value as? UIView {
                views[label] = view
            }
        }
        
        let namesH: [String] = getViewNames(from: H)
        let namesV: [String] = getViewNames(from: V)
        
        if H.starts(with: "|~[") && H.reversed().starts(with: "|~]") {
            views[namesH[0]]!.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            if let size = getSize(from: H) {
                views[namesH[0]]!.widthAnchor.constraint(equalToConstant: size).isActive = true
            }
        } else if !H.isEmpty {
            activateConstraints(format: "H:" + H)
        }
        if V.starts(with: "|~[") && V.reversed().starts(with: "|~]") {
            views[namesV[0]]!.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            if let size = getSize(from: V) {
                views[namesV[0]]!.widthAnchor.constraint(equalToConstant: size).isActive = true
            }
        } else if !V.isEmpty {
            activateConstraints(format: "V:" + V)
        }
        
        func getViewNames(from: String) -> [String] {
            let separated = from.split(separator: "[")
            let filtered = separated.filter { $0.contains("]") }
            let objNames = filtered.map { "\($0.split(separator: "]").first!.split(separator: "(").first!)" }
            return objNames
        }
        func getSize(from: String) -> CGFloat? {
            let strNum = from.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            if let size = Int(strNum) {
                return CGFloat(size)
            }
            return nil
        }
        func activateConstraints(format: String) {
            NSLayoutConstraint.activate(Array(NSLayoutConstraint
                .constraints(withVisualFormat: format, metrics: nil, views: views)
            ))
        }
    }
}
