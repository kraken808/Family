//
//  CreateViewController.swift
//  Family
//
//  Created by Murat Merekov on 31.08.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit
import FirebaseAuth
import SDWebImage
import Firebase
import FirebaseFirestore

class CreateViewController: UIViewController {
  
    
    var memberPickerView = UIPickerView()
    var periodPickerView = UIPickerView()
    var categoryPickerView = UIPickerView()
    var numbersArray = [2,3,4,5,6]
    var periodArray = ["1 Month","2 Month","3 Month", "4 Month or More"]
    let movies = MCategory(name: "Movie", imageUrl: "reel")
    let education = MCategory(name: "Education", imageUrl: "book")
    let music = MCategory(name: "Music", imageUrl: "music")
    
    let mcategory = [MCategory]()
    var category = ["Movies","Education","Music"]
    var toolbar: UIToolbar!
   
    let welcomeLabel = UILabel(text: "Create Post", font: .avenir26())
    
    let fullImageView = AddPhotoView()
    
    let nameLabel = UILabel(text: "Post Name")
    let numberOfUser = UILabel(text: "Number of Members")
    let periodLabel = UILabel(text: "Period")
    let categoryLabel = UILabel(text: "Category")
    
    
    let nameTextField = OneLineTextField(font: .avenir20())
    let numOfMembersTextField = OneLineTextField(font: .avenir20())
    let periodTextField = OneLineTextField(font: .avenir20())
    let categoryTextField = OneLineTextField(font: .avenir20())
    
    let sexSegmentedControl = UISegmentedControl(first: "Male", second: "Femail")
    
    let publicateButton = UIButton(title: "Publish!", titleColor: .white, backgroundColor: .buttonDark(), cornerRadius: 4)
    
    private let currentUser: MUser
    var categories = [MCategory]()
    init(currentUser: MUser) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = .white
        categories.append(movies)
        categories.append(education)
        categories.append(music)
        numOfMembersTextField.inputView = memberPickerView
        periodTextField.inputView = periodPickerView
        categoryTextField.inputView = categoryPickerView
        memberPickerView.delegate = self
        memberPickerView.dataSource = self
        
        periodPickerView.delegate = self
        periodPickerView.dataSource = self
        
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
       
        memberPickerView.tag = 1
        periodPickerView.tag = 2
        categoryPickerView.tag = 3
        
        setupConstraints()
        publicateButton.addTarget(self, action: #selector(publicateButtonTapped), for: .touchUpInside)
        fullImageView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
//             for item in categories{
//                         FirestoreService.shared.saveCategory(name:item.name, iconImage: UIImage(named: item.imageUrl )) { (result) in
//                                                switch result {
//                                                          case .success(let _):
//
//                                                              self.showAlert(with: "Успешно!", and: "Данные сохранены!",completion: {
//                                                              })
//                                                          case .failure(let error):
//                                                              self.showAlert(with: "Ошибка!", and: error.localizedDescription)
//                                                          }
//                                           }
//                 }

    }
    
  
  
//    func creatPickerForMember(){
//
//
//
//
//
//        toolbar = UIToolbar()
//        toolbar.sizeToFit()
//
//        let donebtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
//        toolbar.setItems([donebtn], animated: true)
//
//         numOfMembersTextField.inputAccessoryView = toolbar
//        numOfMembersTextField.inputView = pickerView
//
//
//    }
    
    @objc func doneButtonPressed(){
       
     self.view.endEditing(true)
    }
    
    func setupConstraints(){
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField],
                                              axis: .vertical,
                                              spacing: 0)
        let memberStackView = UIStackView(arrangedSubviews: [numberOfUser, numOfMembersTextField],
        axis: .vertical,
        spacing: 0)
          let periodStackView = UIStackView(arrangedSubviews: [periodLabel, periodTextField],
          axis: .vertical,
          spacing: 0)
          let sexStackView = UIStackView(arrangedSubviews: [categoryLabel, categoryTextField],
          axis: .vertical,
          spacing: 12)
          
          publicateButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
          let stackView = UIStackView(arrangedSubviews: [
              nameStackView,
              memberStackView,
              periodStackView,
              sexStackView,
              publicateButton
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
    
    @objc func publicateButtonTapped(){
       
        FirestoreService.shared.savePostInfo(name: nameTextField.text!,
                                             postImage: fullImageView.circleImageView.image,
                                             postOwnerId: currentUser.uid,
                                             numberOfUsers: numOfMembersTextField.text!,
                                             period: periodTextField.text!) { (result) in
            switch result {
            case .success(let mpost):
               
                self.showAlert(with: "Успешно!", and: "Данные сохранены!",completion: {
                    self.nameTextField.text = ""
                    self.numOfMembersTextField.text = ""
                    self.fullImageView.circleImageView.image = nil
                    self.periodTextField.text = ""
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

extension CreateViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        fullImageView.circleImageView.image = image
    }
}

extension CreateViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           switch pickerView.tag {
                    case 1:
                        numOfMembersTextField.text = "\(numbersArray[row])"
                        numOfMembersTextField.resignFirstResponder()
                    case 2:
                        periodTextField.text = periodArray[row]
                        periodTextField.resignFirstResponder()
                    case 3:
                        categoryTextField.text = category[row]
                        categoryTextField.resignFirstResponder()
                    default:
                        return
                    }
             
         }
    }


extension CreateViewController: UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return numbersArray.count
        case 2:
            return periodArray.count
        case 3:
            return category.count
        default:
            return 1
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         switch pickerView.tag {
               case 1:
                   return "\(numbersArray[row])"
               case 2:
                   return periodArray[row]
               case 3:
                   return category[row]
               default:
                   return "Not found!"
               }
        
    }
    
}
