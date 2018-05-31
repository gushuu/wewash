//
//  LoginVC.swift
//  wewash-development
//
//  Created by Salvador De la Rosa on 4/10/18.
//  Copyright © 2018 The W. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate, Alertable {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var authBtn: RoundedShadowButton!
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
        phoneTextField.delegate = self
        view.bindtoKeyboard()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
    }

    @objc func handleScreenTap(sender: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func authBtnWasPressed(_ sender: Any) {
        if emailField.text != nil && passwordField.text != nil && phoneTextField.text != nil {
            authBtn.animateButton(shouldLoad: true, withMessage: "Iniciar Sesión / Crear Cuenta")
            self.view.endEditing(true)
            
            if let email = emailField.text, let password = passwordField.text, let phone = phoneTextField.text {
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    if error == nil {
                        if let user = user {
                                let userData = ["provider": user.providerID, "phone": phone] as [String: Any]
                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: false)
                            }
                        print("Email user authenticated succesffully with Firebase")
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        if let errorCode = AuthErrorCode(rawValue: error!._code){
                            switch errorCode {
                            case .emailAlreadyInUse:
                                self.showAlert("El Email ya se encuentra registrado")
                                self.authBtn.animateButton(shouldLoad: false, withMessage: "Iniciar Sesión / Crear Cuenta")
                            case .wrongPassword:
                                self.showAlert("Contraseña incorrecta")
                                self.authBtn.animateButton(shouldLoad: false, withMessage: "Iniciar Sesión / Crear Cuenta")
                            case .missingEmail:
                                self.showAlert("Ingresa un email válido para continuar")
                                self.authBtn.animateButton(shouldLoad: false, withMessage: "Iniciar Sesión / Crear Cuenta")
                            case .weakPassword:
                                self.showAlert("Tu contraseña debe tener al menos 6 caractéres")
                                self.authBtn.animateButton(shouldLoad: false, withMessage: "Iniciar Sesión / Crear Cuenta")
                            default:
                                self.showAlert("Error inesperado. Inténtelo de nuevo")
                                self.authBtn.animateButton(shouldLoad: false, withMessage: "Iniciar Sesión / Crear Cuenta")
                            }
                        }
                        
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                if let errorCode = AuthErrorCode(rawValue: error!._code){
                                    switch errorCode {
                                    case .invalidEmail:
                                        self.showAlert("Email inválido.")
                                        self.authBtn.animateButton(shouldLoad: false, withMessage: "Iniciar Sesión / Crear Cuenta")
                                    default:
                                        self.showAlert("Error inesperado. Inténtelo de nuevo")
                                        self.authBtn.animateButton(shouldLoad: false, withMessage: "Iniciar Sesión / Crear Cuenta")
                                    }
                                }
                            } else {
                                if let user = user {
                                        let userData = ["provider": user.providerID] as [String: Any]
                                        DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: false)
                                 }
                                print("New user created")
                                self.dismiss(animated: true, completion: nil)
                            }
                        })
                    }
                })
            }
        }
    }
}
