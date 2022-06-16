//
//  ReminderView.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 15.06.2022.
//

import UIKit

class ReminderView: UIView {
    let avatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.crop.circle.fill")
        image.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    let daysLeftLabel: UILabel = {
        let label = UILabel()
        label.text = "days left"
        return label
    }()
    
    let nextBirthdayDateLabel: UILabel = {
        let label = UILabel()
        label.text = "subtitle"
        return label
    }()
    
    // MARK: - Properties
    
    var reminder: Reminder! {
        didSet {
            if let photo = reminder.person.photo {
                avatarImage.image = UIImage(data: photo)
            }
            titleLabel.text = reminder.person.name
            daysLeftLabel.text = "\(reminder.daysLeftToTheNextBirthday) days left"
            nextBirthdayDateLabel.text = "\(reminder.dayOfBirth) \(reminder.monthOfBirth) on \(reminder.dayOfWeekForTheNextBirthday)"
        }
    }
    
    // MARK: - Initializators and override func
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Help func
    
    private func setupViews() {
        addSubviews()
        addConstraints()
        addLeftBorder(withColor: accentColor, borderWidth: 5)
    }
    
    private func addSubviews() {
        addSubview(avatarImage)
        addSubview(titleLabel)
        addSubview(daysLeftLabel)
        addSubview(nextBirthdayDateLabel)
    }
    private func addConstraints() {
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        avatarImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        avatarImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        avatarImage.widthAnchor.constraint(equalTo: avatarImage.heightAnchor).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 8).isActive = true
        
        daysLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        daysLeftLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        daysLeftLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        daysLeftLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        daysLeftLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        nextBirthdayDateLabel.translatesAutoresizingMaskIntoConstraints = false
        nextBirthdayDateLabel.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 8).isActive = true
        nextBirthdayDateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        nextBirthdayDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
}
