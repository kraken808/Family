//
//  RegistrationViewController.swift
//  Family
//
//  Created by Murat Merekov on 31.08.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
class RegistrationViewController: UIViewController {

   var emailadressField: UITextField!
       var nameField: UITextField!
       var loginField: UITextField!
       var passwordRegField: UITextField!
       var grouping: UIStackView!
       var registerButton: UIButton!
       var ref: DatabaseReference!
       var databaseHandle: DatabaseHandle!
       override func viewDidLoad() {
           super.viewDidLoad()

           title = "Registration"
           view.backgroundColor = .white
           
         ref = Database.database().reference()
           
           nameField = UITextField()
           nameField.translatesAutoresizingMaskIntoConstraints = false
           nameField.borderStyle = .roundedRect
           nameField.placeholder = "Name"
           nameField.backgroundColor = .white
           nameField.clearsOnBeginEditing = true
           view.addSubview(nameField)
           
           emailadressField = UITextField()
           emailadressField.translatesAutoresizingMaskIntoConstraints = false
           emailadressField.placeholder = "Email"
           emailadressField.borderStyle = .roundedRect
           emailadressField.backgroundColor = .white
           emailadressField.clearsOnBeginEditing = true
           view.addSubview(emailadressField)
           
           loginField = UITextField()
           loginField.translatesAutoresizingMaskIntoConstraints = false
           loginField.borderStyle = .roundedRect
           loginField.placeholder = "Login"
           loginField.backgroundColor = .white
           loginField.clearsOnBeginEditing = true
           view.addSubview(loginField)
           
           passwordRegField = UITextField()
           passwordRegField.borderStyle = .roundedRect
           passwordRegField.placeholder = "Password"
           passwordRegField.isSecureTextEntry = true
           passwordRegField.backgroundColor = .white
           passwordRegField.clearsOnBeginEditing = true
           passwordRegField.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(passwordRegField)
           
          
           
           registerButton = UIButton()
           registerButton.translatesAutoresizingMaskIntoConstraints = false
           registerButton.setTitle("Register", for: .normal)
           registerButton.setTitleColor(.blue, for: .normal)
           registerButton.layer.cornerRadius = 5
           registerButton.layer.borderWidth = 1
           registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
               
           
           registerButton.layer.borderColor = UIColor.black.cgColor
           view.addSubview(registerButton)
           
           grouping = UIStackView(arrangedSubviews: [nameField,emailadressField,loginField,passwordRegField,registerButton])
                  grouping.translatesAutoresizingMaskIntoConstraints = false
                  grouping.axis = NSLayoutConstraint.Axis.vertical
                  grouping.distribution = .equalSpacing
                  grouping.alignment = .center
                  grouping.spacing = 15
                  view.addSubview(grouping)
           
           setupConstraints()

       }
       
       func setupConstraints(){
           NSLayoutConstraint.activate([
               grouping.centerYAnchor.constraint(equalTo: view.centerYAnchor),
               grouping.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               
               nameField.widthAnchor.constraint(equalToConstant: 270),
               nameField.heightAnchor.constraint(equalToConstant: 40),
               
               emailadressField.widthAnchor.constraint(equalToConstant: 270),
               emailadressField.heightAnchor.constraint(equalToConstant: 40),
               
               loginField.widthAnchor.constraint(equalToConstant: 270),
               loginField.heightAnchor.constraint(equalToConstant: 40),
               
               passwordRegField.widthAnchor.constraint(equalToConstant: 270),
               passwordRegField.heightAnchor.constraint(equalToConstant: 40),
               
               registerButton.widthAnchor.constraint(equalToConstant: 270),
               registerButton.heightAnchor.constraint(equalToConstant: 40)
               
           ])
       }
    
    func validateFields() -> Int?{
        if nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailadressField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordRegField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return 1
        }
        let cleanedPassword = passwordRegField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isPasswordValid(cleanedPassword!) == false{
            return 2
        }
        return 3
    }
       
       @objc func registerButtonPressed(){
        
     
        if validateFields() == 1{
            let ac = UIAlertController(title: nil, message: "Please fill the all field", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                       present(ac, animated: true, completion: nil)
        }
        else if validateFields() == 2{
                 
                 let ac = UIAlertController(title: nil, message: "Please make sure that password has Minimum 8 characters at least 1 Alphabet and 1 Number", preferredStyle: .alert)
                 ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            present(ac, animated: true, completion: nil)
                 
                 
             }
        else{
           
        guard let name = nameField.text else{ return }
        guard let email = emailadressField.text else{ return }
        guard let password = passwordRegField.text else { return}
        guard let lname = loginField.text else{ return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
             if error == nil && user != nil{
                print("user is created!")
                self.ref.child("Users").child(user!.user.uid).setValue(["firstname": name,"lastName":lname])

             }else{
                print("error in creation user: \(error?.localizedDescription)")
            }
        }
        
          
           let alert = UIAlertController(title: "Successful!", message: "Registration is done!", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Continue", style: .default, handler: {
                            action in
                            UIApplication.shared.keyWindow?.rootViewController = LoginViewController()
                        })
                        
                        alert.addAction(action)
                        
                        present(alert, animated: true, completion: nil)
        }
       }
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$")
        return passwordTest.evaluate(with: password)
    }


}
