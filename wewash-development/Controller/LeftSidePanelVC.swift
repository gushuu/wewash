//
//  LeftSidePanelVC.swift
//  wewash-development
//
//  Created by Salvador De la Rosa on 4/9/18.
//  Copyright © 2018 The W. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class LeftSidePanelVC: UIViewController {
    
//    let currentUserId = Auth.auth().currentUser?.uid
    
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var userAccountTypeLbl: UILabel!
    @IBOutlet weak var userImageView: RoundImageView!
    @IBOutlet weak var loginOutBtn: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        observePassengerAndDrivers()
        
        if Auth.auth().currentUser == nil {
            userEmailLbl.text = ""
            userAccountTypeLbl.text = ""
            userImageView.isHidden = true
            loginOutBtn.setTitle("Inicias Sesión / Crear Cuenta", for: .normal)
        } else {
            userEmailLbl.text = Auth.auth().currentUser?.email
            userAccountTypeLbl.text = ""
            userImageView.isHidden = false
            loginOutBtn.setTitle("Cerrar Sesión", for: .normal)
        }
    
    }

    func observePassengerAndDrivers() {
        DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.userAccountTypeLbl.text = "CLIENTE"
                    }
                }
            }
        })
    }


    
    @IBAction func frequentQuestionsBtnWasPressed(_ sender: Any) {
        let frequentQuestions = storyboard?.instantiateViewController(withIdentifier: "frequentQuestions") as? frequentQuestionsVC
        present(frequentQuestions!, animated: true, completion: nil)
    }
    

    
    @IBAction func pricesBtnWasPressed(_ sender: Any) {
        let prices = storyboard?.instantiateViewController(withIdentifier: "prices") as? pricesVC
        present(prices!, animated: true, completion: nil)
    }
    
    
    @IBAction func signUpLoginBtnPressed(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
            present(loginVC!, animated: true, completion: nil)
        } else {
            do {
                try Auth.auth().signOut()
                userEmailLbl.text = ""
                userAccountTypeLbl.text = ""
                userImageView.isHidden = true
                loginOutBtn.setTitle("Inicias Sesión / Crear Cuenta", for: .normal)
            } catch (let error) {
                print(error)
            }
        }
    }
}
