//
//  ReminderView.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 15.06.2022.
//

import UIKit

class ReminderView: UIView {
    let photoImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = .systemGray2
        image.image = AppConstants.emptyPhoto
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    let daysLeftLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.text = "days left"
        return label
    }()
    
    let nextBirthdayDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.text = "subtitle"
        return label
    }()
    
    // MARK: - Properties
    
    var reminder: Reminder! {
        didSet {
            if let photo = reminder.person.photo {
                photoImage.image = UIImage(data: photo)
            }
            titleLabel.text = reminder.person.name
            daysLeftLabel.text = "\(reminder.daysLeft) days left"
            nextBirthdayDateLabel.text = "\(reminder.day) \(reminder.month) on \(reminder.weekday)"
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
        self.addBorder(to: .left, color: AppConstants.accentColor, width: 5)
    }
    
    // MARK: - Help methods
    
    private func setupViews() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(photoImage)
        addSubview(titleLabel)
        addSubview(daysLeftLabel)
        addSubview(nextBirthdayDateLabel)
    }
    
    private func addConstraints() {
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        daysLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        nextBirthdayDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let width = frame.height - 8
        addConstraints(H: "|-16-[photoImage(\(width))]", V: "|-4-[photoImage]-4-|")
        addConstraints(H: "[photoImage]-8-[titleLabel]", V: "|-8-[titleLabel]")
        addConstraints(H: "[titleLabel]-[daysLeftLabel]-8-|", V: "|-8-[daysLeftLabel]")
        addConstraints(H: "[photoImage]-8-[nextBirthdayDateLabel]-8-|", V: "[nextBirthdayDateLabel]-8-|")
    }
}
