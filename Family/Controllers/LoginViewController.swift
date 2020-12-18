//
//  LoginViewController.swift
//  Family
//
//  Created by Murat Merekov on 31.08.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
class LoginViewController: UIViewController {

      var emailField: UITextField!
        var passwordField: UITextField!
        var loginButton: UIButton!
        var registerButton: UIButton!
        var stackView: UIStackView!
        var forgotPasswordButton: UIButton!
        var googleSignInButton: GIDSignInButton!
       
        override func viewDidLoad() {
            super.viewDidLoad()
           
            self.navigationController?.navigationBar.isHidden = true
            view.backgroundColor = .white
            
       
                
            
            
            
            registerButton = UIButton()
            registerButton.translatesAutoresizingMaskIntoConstraints = false
            registerButton.setTitle("Registration", for: .normal)
            registerButton.setTitleColor(.blue, for: .normal)
            registerButton.addTarget(self, action: #selector(gotoRegister), for: .touchUpInside)
            view.addSubview(registerButton)
            
            emailField = UITextField()
            emailField.translatesAutoresizingMaskIntoConstraints = false
            emailField.borderStyle = .roundedRect
            emailField.placeholder = "Login"
            emailField.backgroundColor = .white
            emailField.textAlignment = .center
            emailField.clearsOnBeginEditing = true
            view.addSubview(emailField)
            
            passwordField = UITextField()
            passwordField.borderStyle = .roundedRect
            passwordField.placeholder = "Password"
            passwordField.isSecureTextEntry = true
            passwordField.backgroundColor = .white
            passwordField.textAlignment = .center
            passwordField.clearsOnBeginEditing = true
            passwordField.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(passwordField)
            
            loginButton = UIButton()
            loginButton.setTitle("Log In", for: .normal)
            loginButton.layer.cornerRadius = 5
            loginButton.layer.borderWidth = 1
            loginButton.layer.borderColor = UIColor.black.cgColor
            loginButton.setTitleColor(.blue, for: .normal)
            loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
            loginButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(loginButton)
            
            forgotPasswordButton = UIButton()
            forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
            forgotPasswordButton.setTitleColor(.gray, for: .normal)
            forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
            forgotPasswordButton.addTarget(self, action: #selector(gotoforgotPassword), for: .touchUpInside)
            view.addSubview(forgotPasswordButton)
            
            stackView = UIStackView(arrangedSubviews: [emailField,passwordField,loginButton,forgotPasswordButton])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            stackView.axis = NSLayoutConstraint.Axis.vertical
            stackView.distribution = .equalSpacing
            stackView.alignment = .center
            stackView.spacing = 15
            view.addSubview(stackView)
            
            GIDSignIn.sharedInstance()?.presentingViewController = self
            GIDSignIn.sharedInstance().signIn()
            
            googleSignInButton = GIDSignInButton()
            googleSignInButton.translatesAutoresizingMaskIntoConstraints = false
            googleSignInButton.layer.cornerRadius = 5
            googleSignInButton.layer.borderWidth = 1
            view.addSubview(googleSignInButton)
            
            setupConstriants()
          
        }
        
       
        

        func setupConstriants(){
            NSLayoutConstraint.activate([
    //            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    //            passwordField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                passwordField.widthAnchor.constraint(equalToConstant: 250),
                passwordField.heightAnchor.constraint(equalToConstant: 40),
    //
    //            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    //            emailField.bottomAnchor.constraint(equalTo: passwordField.topAnchor, constant: 20),
                emailField.widthAnchor.constraint(equalToConstant: 250),
                emailField.heightAnchor.constraint(equalToConstant: 40),
    //
    //            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 15),
    //            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loginButton.widthAnchor.constraint(equalToConstant: 250),
                loginButton.heightAnchor.constraint(equalToConstant: 40),
                
                stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
                registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                googleSignInButton.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -15),
                googleSignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
        
        @objc func gotoforgotPassword(){
           
        }
        
        @objc func loginAction(){
          
          
                  guard let email = emailField.text else{ return }
                  guard let password = passwordField.text else { return}
                 
            Auth.auth().signIn(withEmail: email, password: password) { (res, error) in
              
                     guard let res = res else {
                         let ac = UIAlertController(title: nil, message: "Incorrect login or password", preferredStyle: .alert)
                                        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(ac, animated: true, completion: nil)
                              return
                          }
            
    
                
                FirestoreService.shared.getUserData(user: res.user) { (result) in
                    switch result {
                                    case .success(let user):
                                                  
UIApplication.shared.keyWindow?.rootViewController = MenuViewController(currentUser: user)
                                                  
                                              case .failure(_):
                                                UIApplication.shared.keyWindow?.rootViewController = SetupUserViewController(currentUser: res.user)
                                              }
                }
                
                
//                    let user = Auth.auth().currentUser
//                    if let user = user{
//
//                UIApplication.shared.keyWindow?.rootViewController = SetupUserViewController(currentUser: user)
                    
                    
                   
                    
                
            }
                    
          
            
            
        }
    
        
        @objc func gotoRegister(){
          
             UIApplication.shared.keyWindow?.rootViewController = RegistrationViewController()
        }

}


