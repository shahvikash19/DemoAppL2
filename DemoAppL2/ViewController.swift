//  ViewController.swift
//  DemoAppL2
//
//  Created by Vikas Hareram Shah on 13/02/25.

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var emailIdTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = UserDefaults.standard.string(forKey: "UserEmail") {
            // navigateToHome()
        }
    }
    
    @IBAction func LoginBtnTapped(_ sender: UIButton) {
        guard let email = emailIdTF.text, !email.isEmpty,
              let password = passwordTF.text, !password.isEmpty else {
            showAlert(message: "Please enter both email and password.")
            return
        }
        
        // Save login details in UserDefaults
        UserDefaults.standard.set(email, forKey: "UserEmail")
        UserDefaults.standard.set(password, forKey: "UserPassword")
        UserDefaults.standard.synchronize()
        
        navigateToHome()
    }
    
    
    func navigateToHome() {
        if let VC = storyboard?.instantiateViewController(withIdentifier: "ViewController2") as? ViewController2 {
            navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
}



//    @IBAction func signinBtnTapped(_ sender: UIButton) {
//        // GIDSignIn.sharedInstance.signin()
//    }
