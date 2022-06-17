//
//  AddReminderViewController.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 15.06.2022.
//

import UIKit

class AddReminderViewController: UIViewController {
    // MARK: - UI Elements
    
    let cancelButton: UIButton = {
        var config: UIButton.Configuration = .plain()
        config.baseForegroundColor = accentColor
        config.title = "Cancel"
        let button = UIButton(configuration: config)
        button.addTarget(nil, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let addButton: UIButton = {
        var config: UIButton.Configuration = .plain()
        config.baseForegroundColor = accentColor
        config.title = "Add"
        let button = UIButton(configuration: config)
        button.addTarget(nil, action: #selector(addButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .systemGray2
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let addPhotoButton: UIButton = {
        var config: UIButton.Configuration = .plain()
        config.baseForegroundColor = accentColor
        config.title = "Add photo"
        let button = UIButton(configuration: config)
        button.addTarget(nil, action: #selector(addPhotoButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let nameLabel: UILabel = {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: accentColor
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
        return textField
    }()
    
    let birthDateLabel: UILabel = {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: accentColor
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
        return textField
    }()
    
    let ageLabel: UILabel = {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: accentColor
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
        return textField
    }()
    
    let genderLabel: UILabel = {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: accentColor
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
        return textField
    }()
    
    let instagramLabel: UILabel = {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: accentColor
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
        return textField
    }()
    
    let photoLibraryPicker = UIImagePickerController()
    
    // MARK: - My properties
    
    var addCompletion: ((Person) -> Void)?
    
    // MARK: - Life cycle and override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - Actions
    
    @objc private func cancelButtonPressed() {
        self.dismiss(animated: true)
    }
    
    @objc private func addButtonPressed() {
//        let photo = addPhotoButton.currentImage
//        guard let name = nameTextField.text else { return }
//        guard let age = ageTextField.text else { return }
//        guard let birthDate = birthDateTextField.text else { return }
//        guard let gender = genderTextField.text else { return }
//        let instagram = instagramTextField.text
//        let person = Person(photo: photo, name: name, age: age, birthDate: birthDate, gender: gender, instagram: instagram)
//        addCompletion?(person)
    }
    
    @objc private func addPhotoButtonPressed() {
        present(photoLibraryPicker, animated: true)
    }
    
    // MARK: - Help methods
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        photoLibraryPicker.delegate = self
        
        addSubviews()
        addConstraints()
        
        view.layoutIfNeeded()
        nameTextField.addBorder(at: .bottom, color: .systemGray2, width: 1)
        birthDateTextField.addBorder(at: .bottom, color: .systemGray2, width: 1)
        ageTextField.addBorder(at: .bottom, color: .systemGray2, width: 1)
        genderTextField.addBorder(at: .bottom, color: .systemGray2, width: 1)
        instagramTextField.addBorder(at: .bottom, color: .systemGray2, width: 1)
    }
    
    private func addSubviews() {
        view.addSubview(cancelButton)
        view.addSubview(addButton)
        view.addSubview(addPhotoButton)
        view.addSubview(avatarImage)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(birthDateLabel)
        view.addSubview(birthDateTextField)
        view.addSubview(ageLabel)
        view.addSubview(ageTextField)
        view.addSubview(genderLabel)
        view.addSubview(genderTextField)
        view.addSubview(instagramLabel)
        view.addSubview(instagramTextField)
    }
    
    private func addConstraints() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(target: self, H: "|-8-[cancelButton]", V: "|-12-[cancelButton]")
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(target: self, H: "[addButton]-8-|", V: "|-12-[addButton]")
        
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        let spacing = view.frame.width / 2 - 100 / 2
        view.addConstraints(target: self, H: "|-\(spacing)-[avatarImage(100)]-\(spacing)-|", V: "[addButton]-8-[avatarImage(100)]")
        
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(target: self, H: "|[addPhotoButton]|", V: "[avatarImage]-8-[addPhotoButton]")
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(target: self, H: "|-40-[nameLabel]-40-|", V: "[addPhotoButton]-35-[nameLabel]")
                
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(target: self, H: "|-40-[nameTextField]-40-|", V: "[nameLabel]-15-[nameTextField]")
        
        birthDateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(target: self, H: "|-40-[birthDateLabel]-40-|", V: "[nameTextField]-35-[birthDateLabel]")
                
        birthDateTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(target: self, H: "|-40-[birthDateTextField]-40-|", V: "[birthDateLabel]-15-[birthDateTextField]")
        
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(target: self, H: "|-40-[ageLabel]-40-|", V: "[birthDateTextField]-35-[ageLabel]")
                
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(target: self, H: "|-40-[ageTextField]-40-|", V: "[ageLabel]-15-[ageTextField]")
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(target: self, H: "|-40-[genderLabel]-40-|", V: "[ageTextField]-35-[genderLabel]")
                
        genderTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(target: self, H: "|-40-[genderTextField]-40-|", V: "[genderLabel]-15-[genderTextField]")
        
        instagramLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(target: self, H: "|-40-[instagramLabel]-40-|", V: "[genderTextField]-35-[instagramLabel]")
                
        instagramTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(target: self, H: "|-40-[instagramTextField]-40-|", V: "[instagramLabel]-15-[instagramTextField]")
    }
}

extension AddReminderViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let original = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            avatarImage.image = original
            dismiss(animated: true)
        }
    }
}
