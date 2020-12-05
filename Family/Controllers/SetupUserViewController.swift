//
//  SetupUserViewController.swift
//  Family
//
//  Created by Murat Merekov on 11.11.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit
import FirebaseAuth
import SDWebImage
import Firebase
import FirebaseFirestore

class SetupUserViewController: UIViewController {
     var datePicker: UIDatePicker!
    var toolbar = UIToolbar()
    
     var dateFormatter: DateFormatter!
    let welcomeLabel = UILabel(text: "Set up profile!", font: .avenir26())
    
    let fullImageView = AddPhotoView()
    
    let nameLabel = UILabel(text: "Fist name")
    let lnameLabel = UILabel(text: "Last name")
    let birthLabel = UILabel(text: "Birth date")
    let sexLabel = UILabel(text: "Sex")
    
    
    let nameTextField = OneLineTextField(font: .avenir20())
    let lnameTextField = OneLineTextField(font: .avenir20())
    let birthTextField = OneLineTextField(font: .avenir20())
    
    let sexSegmentedControl = UISegmentedControl(first: "Male", second: "Femail")
    
    let goToChatsButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .buttonDark(), cornerRadius: 4)
    
    private let currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        
        if let username = currentUser.displayName {
            nameTextField.text = username
        }
        if let photoURL = currentUser.photoURL {
            fullImageView.circleImageView.sd_setImage(with: photoURL, completed: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        birthTextField.placeholder = "MM/DD/YYYY"
        setupConstraints()
        goToChatsButton.addTarget(self, action: #selector(goToChatsButtonTapped), for: .touchUpInside)
        fullImageView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    
        creatDatePicker()
          
             

    }
  
    func creatDatePicker(){
        datePicker = UIDatePicker()
         toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let donebtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        toolbar.setItems([donebtn], animated: true)
        datePicker.datePickerMode = .date
        birthTextField.inputAccessoryView = toolbar
        
        birthTextField.inputView = datePicker
    }
    
    @objc func doneButtonPressed(){
         dateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        // Apply date format
        let birthD = dateFormatter.string(from: datePicker.date)
        birthTextField.text = birthD
        self.view.endEditing(true)
    }
    
    func setupConstraints(){
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField],
                                              axis: .vertical,
                                              spacing: 0)
        let lnameStackView = UIStackView(arrangedSubviews: [lnameLabel, lnameTextField],
        axis: .vertical,
        spacing: 0)
          let birthStackView = UIStackView(arrangedSubviews: [birthLabel, birthTextField],
          axis: .vertical,
          spacing: 0)
          let sexStackView = UIStackView(arrangedSubviews: [sexLabel, sexSegmentedControl],
          axis: .vertical,
          spacing: 12)
          
          goToChatsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
          let stackView = UIStackView(arrangedSubviews: [
              nameStackView,
              lnameStackView,
              birthStackView,
              sexStackView,
              goToChatsButton
              ], axis: .vertical, spacing: 40)
          
          welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
          fullImageView.translatesAutoresizingMaskIntoConstraints = false
          stackView.translatesAutoresizingMaskIntoConstraints = false
          
          view.addSubview(welcomeLabel)
          view.addSubview(fullImageView)
          view.addSubview(stackView)
          
          NSLayoutConstraint.activate([
              welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
              welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
          ])
          
          NSLayoutConstraint.activate([
              fullImageView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
              fullImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
          ])
          
          NSLayoutConstraint.activate([
              stackView.topAnchor.constraint(equalTo: fullImageView.bottomAnchor, constant: 40),
              stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
              stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
          ])
    }
    
    @objc func goToChatsButtonTapped(){
       
        FirestoreService.shared.saveUserInfo(id: currentUser.uid,
                                             email: currentUser.email!,
                                             name: nameTextField.text!,
                                             lname: lnameTextField.text!,
                                             avatarImage: fullImageView.circleImageView.image,
                                             sex: sexSegmentedControl.titleForSegment(at: sexSegmentedControl.selectedSegmentIndex),
                                             dbirth: birthTextField.text!){ (result) in
                                             switch result {
                                             case .success(let muser):
                                                 self.showAlert(with: "Успешно!", and: "Данные сохранены!", completion: {
                                                     UIApplication.shared.keyWindow?.rootViewController = MenuViewController(currentUser: muser)
                                                 })
                                             case .failure(let error):
                                                 self.showAlert(with: "Ошибка!", and: error.localizedDescription)
                                             }
         
    }
}
    
    @objc func plusButtonTapped(){
         let imagePickerController = UIImagePickerController()
          imagePickerController.delegate = self
           imagePickerController.sourceType = .photoLibrary
           present(imagePickerController, animated: true, completion: nil)
    }

}

extension SetupUserViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        fullImageView.circleImageView.image = image
    }
}
