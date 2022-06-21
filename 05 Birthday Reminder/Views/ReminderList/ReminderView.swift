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
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
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
    
    override func layoutSubviews() {
        avatarImage.layer.cornerRadius = (frame.height - 16) / 2
        self.addBorder(to: .left, color: accentColor, width: 5)
    }
    
    // MARK: - Help methods
    
    private func setupViews() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(avatarImage)
        addSubview(titleLabel)
        addSubview(daysLeftLabel)
        addSubview(nextBirthdayDateLabel)
    }
    
    private func addConstraints() {
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        daysLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        nextBirthdayDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let width = frame.height - 16
        addConstraints(H: "|-8-[avatarImage(\(width))]", V: "|-8-[avatarImage]-8-|")
        addConstraints(H: "[avatarImage]-8-[titleLabel]", V: "|-8-[titleLabel]")
        addConstraints(H: "[titleLabel]-[daysLeftLabel]-8-|", V: "|-8-[daysLeftLabel]")
        addConstraints(H: "[avatarImage]-8-[nextBirthdayDateLabel]-8-|", V: "[nextBirthdayDateLabel]-8-|")
    }
}
