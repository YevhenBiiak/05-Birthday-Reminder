//
//  EditReminderView.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 20.06.2022.
//

import UIKit
import PhotosUI

class EditReminderView: UIView {
    let photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .systemGray2
        imageView.image = AppConstants.emptyPhoto
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let addPhotoButton: UIButton = {
        var config: UIButton.Configuration = .plain()
        config.baseForegroundColor = AppConstants.accentColor
        config.title = "Add photo"
        let button = UIButton(configuration: config)
        return button
    }()
    
    let nameLabel: UILabel = {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: AppConstants.accentColor
        ]
        let attrString = NSAttributedString(string: "Name", attributes: attributes)
        let label = UILabel()
        label.attributedText = attrString
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = "Enter the name"
        textField.tag = 0
        return textField
    }()
    
    let birthDateLabel: UILabel = {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: AppConstants.accentColor
        ]
        let attrString = NSAttributedString(string: "Birth date", attributes: attributes)
        let label = UILabel()
        label.attributedText = attrString
        return label
    }()
    
    let birthDateTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = "Enter date of birth"
        textField.tag = 1
        return textField
    }()
    
    let ageLabel: UILabel = {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: AppConstants.accentColor
        ]
        let attrString = NSAttributedString(string: "Age", attributes: attributes)
        let label = UILabel()
        label.attributedText = attrString
        return label
    }()
    
    let ageTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = "Enter the age"
        textField.tag = 2
        return textField
    }()
    
    let genderLabel: UILabel = {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: AppConstants.accentColor
        ]
        let attrString = NSAttributedString(string: "Gender", attributes: attributes)
        let label = UILabel()
        label.attributedText = attrString
        return label
    }()
    
    let genderTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = "Enter the gender"
        textField.tag = 3
        return textField
    }()
    
    let instagramLabel: UILabel = {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: AppConstants.accentColor
        ]
        let attrString = NSAttributedString(string: "Instagram", attributes: attributes)
        let label = UILabel()
        label.attributedText = attrString
        return label
    }()
    
    let instagramTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = "Enter the instagram account"
        textField.tag = 4
        return textField
    }()
    
    let deleteReminderButton: UIButton = {
        var config: UIButton.Configuration = .plain()
        config.baseForegroundColor = UIColor.red
        config.title = "Delete reminder"
        let button = UIButton(configuration: config)
        return button
    }()
    
    let toolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 45)))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        toolbar.setItems([UIBarButtonItem.flexibleSpace(), doneButton], animated: true)
        return toolbar
    }()
    
    let photoLibrary: PHPickerViewController = {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        return picker
    }()
    
    let birthDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = today
        return datePicker
    }()
    
    let agePicker = UIPickerView()
    let genderPicker = UIPickerView()
    
    // MARK: - Initializators and overide methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBorders()
        photoImage.layer.cornerRadius = photoImage.frame.width / 2
    }
    
    // MARK: - Help methods
    
    private func setupViews() {
        addSubviews()
        addConstraints()
        
        birthDateTextField.inputView = birthDatePicker
        birthDateTextField.inputAccessoryView = toolbar
        
        ageTextField.inputView = agePicker
        ageTextField.inputAccessoryView = toolbar
        
        genderTextField.inputView = genderPicker
        genderTextField.inputAccessoryView = toolbar
    }
    
    private func addSubviews() {
        addSubview(addPhotoButton)
        addSubview(photoImage)
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(birthDateLabel)
        addSubview(birthDateTextField)
        addSubview(ageLabel)
        addSubview(ageTextField)
        addSubview(genderLabel)
        addSubview(genderTextField)
        addSubview(instagramLabel)
        addSubview(instagramTextField)
        addSubview(deleteReminderButton)
    }
    
    private func addConstraints() {
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        birthDateLabel.translatesAutoresizingMaskIntoConstraints = false
        birthDateTextField.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderTextField.translatesAutoresizingMaskIntoConstraints = false
        instagramLabel.translatesAutoresizingMaskIntoConstraints = false
        instagramTextField.translatesAutoresizingMaskIntoConstraints = false
        deleteReminderButton.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints(H: "|~[photoImage(100)]~|", V: "|-80-[photoImage(100)]")
        addConstraints(H: "|~[addPhotoButton]~|", V: "[photoImage]-8-[addPhotoButton]")
        addConstraints(H: "|-40-[nameLabel]-40-|", V: "[addPhotoButton]-25-[nameLabel]")
        addConstraints(H: "|-40-[nameTextField]-40-|", V: "[nameLabel]-15-[nameTextField]")
        addConstraints(H: "|-40-[birthDateLabel]-40-|", V: "[nameTextField]-35-[birthDateLabel]")
        addConstraints(H: "|-40-[birthDateTextField]-40-|", V: "[birthDateLabel]-15-[birthDateTextField]")
        addConstraints(H: "|-40-[ageLabel]-40-|", V: "[birthDateTextField]-35-[ageLabel]")
        addConstraints(H: "|-40-[ageTextField]-40-|", V: "[ageLabel]-15-[ageTextField]")
        addConstraints(H: "|-40-[genderLabel]-40-|", V: "[ageTextField]-35-[genderLabel]")
        addConstraints(H: "|-40-[genderTextField]-40-|", V: "[genderLabel]-15-[genderTextField]")
        addConstraints(H: "|-40-[instagramLabel]-40-|", V: "[genderTextField]-35-[instagramLabel]")
        addConstraints(H: "|-40-[instagramTextField]-40-|", V: "[instagramLabel]-15-[instagramTextField]")
        addConstraints(H: "|-40-[deleteReminderButton]-40-|", V: "[instagramTextField]-50-[deleteReminderButton]")
    }
    
    private func addBorders() {
        nameTextField.addBorder(to: .bottom, color: .systemGray2, width: 1)
        birthDateTextField.addBorder(to: .bottom, color: .systemGray2, width: 1)
        ageTextField.addBorder(to: .bottom, color: .systemGray2, width: 1)
        genderTextField.addBorder(to: .bottom, color: .systemGray2, width: 1)
        instagramTextField.addBorder(to: .bottom, color: .systemGray2, width: 1)
    }
}
