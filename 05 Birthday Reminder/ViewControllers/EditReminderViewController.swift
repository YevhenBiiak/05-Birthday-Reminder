//
//  EditReminderViewController.swift
//  05 Birthday Reminder
//
//  Created by Евгений Бияк on 15.06.2022.
//

import UIKit
import PhotosUI

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
        editReminderView.photoLibrary.delegate = self
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
        editReminderView.birthDatePicker.addTarget(nil, action: #selector(birthDateSelected(picker:)), for: .valueChanged)
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        
        let photo = editReminderView.photoImage.image != AppConstants.emptyPhoto ?
            editReminderView.photoImage.image : nil
        
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
        present(editReminderView.photoLibrary, animated: true)
    }
    @objc private func deleteReminderButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    @objc private func birthDateSelected(picker: UIDatePicker) {
        let date = picker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        
        let dateValue = dateFormatter.string(from: date)
        editReminderView.birthDateTextField.text = dateValue
        
        print("date: ", date)
        let age = calendar.dateComponents([.year], from: date, to: today).year! - 1
        print("date: ", age)
        editReminderView.ageTextField.text = String(age)
        editReminderView.agePicker.selectRow(age, inComponent: 0, animated: false)
    }
    
    @objc private func donePickerButtonPressed() {
        view.endEditing(true)
    }
}

// MARK: - Extensions for delegates

// Text Field Delegate
extension EditReminderViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addBorder(to: .bottom, color: .systemGray2, width: 1)
        
        // update text field that Did Begin Editing with the currently selected item in the picker
        switch textField.tag {
        case 1: birthDateSelected(picker: editReminderView.birthDatePicker)
        case 2: let currentRow = editReminderView.agePicker.selectedRow(inComponent: 0)
                editReminderView.ageTextField.text = String(currentRow)
        case 3: let currentRow = editReminderView.genderPicker.selectedRow(inComponent: 0)
                editReminderView.genderTextField.text = Person.Gender.allCases[currentRow].rawValue
        default: break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

// Photo Picker Delegate
extension EditReminderViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider

        guard let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
        
        itemProvider.loadObject(ofClass: UIImage.self) { image, error in
            DispatchQueue.main.async { [unowned self] in
                guard let image = image as? UIImage, error == nil else { return }
                editReminderView.photoImage.image = image
            }
        }
    }
}

// Picker View Delegate - Age and Gender
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
            
            let pickerDate = editReminderView.birthDatePicker.date
            var components = calendar.dateComponents([.day, .month], from: pickerDate)
            let yearOfBirth = calendar.date(byAdding: .year, value: -row - 1, to: today)!
            print()
            components.year = calendar.dateComponents([.year], from: yearOfBirth).year
            print(components.year)
            if let newDate = calendar.date(from: components) {
                print("age: ", row)
                print("age: ", newDate)
                editReminderView.birthDatePicker.date = newDate
                birthDateSelected(picker: editReminderView.birthDatePicker)
            }
        } else {
            editReminderView.genderTextField.text = Person.Gender.allCases[row].rawValue
        }
    }
}
