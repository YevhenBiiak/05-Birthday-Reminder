//
//  EditReminderViewController.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 15.06.2022.
//

import UIKit

class EditReminderViewController: UIViewController {
    
    private var editReminderView: EditReminderView!
    var editReminderCompletion: ((Person) -> Void)?
    
    // MARK: - Life cycle and override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    // MARK: - Help methods
    
    private func setup() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        
        editReminderView = EditReminderView(frame: view.frame)
        view.addSubview(editReminderView)
        
        addActions()
        setDelegateToAllTextFields()
        setDataSourceAndDelegatToPickerViews()
        editReminderView.photoLibraryPicker.delegate = self
    }
    
    private func setDelegateToAllTextFields() {
        editReminderView.nameTextField.delegate = self
        editReminderView.birthDateTextField.delegate = self
        editReminderView.ageTextField.delegate = self
        editReminderView.genderTextField.delegate = self
        editReminderView.instagramTextField.delegate = self
    }
    
    private func addActions() {
        editReminderView.addPhotoButton.addTarget(nil, action: #selector(addPhotoButtonPressed), for: .touchUpInside)
        editReminderView.deleteReminderButton.addTarget(nil, action: #selector(deleteReminderButtonPressed), for: .touchUpInside)
        editReminderView.birthDatePicker.addTarget(nil, action: #selector(birthDateSelected), for: .valueChanged)
        editReminderView.toolbar.items?.last?.action = #selector(donePickerButtonPressed)
    }
    
    private func setDataSourceAndDelegatToPickerViews() {
        editReminderView.agePicker.dataSource = self
        editReminderView.agePicker.delegate = self
        editReminderView.genderPicker.dataSource = self
        editReminderView.genderPicker.delegate = self
    }
    
    // MARK: - Actions
    
    @objc private func doneButtonPressed() {
        let photo = editReminderView.avatarImage.image
        
        guard let name = editReminderView.nameTextField.text, !name.isEmpty else {
            editReminderView.nameTextField.addBorder(to: .bottom, color: .red, width: 1)
            return
        }
        guard let date = editReminderView.birthDateTextField.text, !date.isEmpty else {
            editReminderView.birthDateTextField.addBorder(to: .bottom, color: .red, width: 1)
            return
        }
        guard let age = Int(editReminderView.ageTextField.text!) else {
            editReminderView.ageTextField.addBorder(to: .bottom, color: .red, width: 1)
            return
        }
        guard let gender = editReminderView.genderTextField.text, !gender.isEmpty else {
            editReminderView.genderTextField.addBorder(to: .bottom, color: .red, width: 1)
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        guard let birthDate = dateFormatter.date(from: date) else {
            editReminderView.birthDateTextField.addBorder(to: .bottom, color: .red, width: 1)
            return
        }
        
        let instagram = editReminderView.instagramTextField.text
        
        let person = Person(photo: photo, name: name, age: age, birthDate: birthDate, gender: gender, instagram: instagram)
        
        editReminderCompletion?(person)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func addPhotoButtonPressed() {
        present(editReminderView.photoLibraryPicker, animated: true)
    }
    @objc private func deleteReminderButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    @objc private func birthDateSelected() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let dateValue = dateFormatter.string(from: editReminderView.birthDatePicker.date)
        editReminderView.birthDateTextField.text = dateValue
    }
    
    @objc private func donePickerButtonPressed() {
        view.endEditing(true)
    }
}

// MARK: - Extensions for delegates

extension EditReminderViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addBorder(to: .bottom, color: .systemGray2, width: 1)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension EditReminderViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let original = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            editReminderView.avatarImage.image = original
            dismiss(animated: true)
        }
    }
}

extension EditReminderViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == editReminderView.agePicker ? 100 : Person.Gender.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView == editReminderView.agePicker ? String(row) : Person.Gender.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == editReminderView.agePicker {
            editReminderView.ageTextField.text = String(row)
        } else {
            editReminderView.genderTextField.text = Person.Gender.allCases[row].rawValue
        }
    }
}
