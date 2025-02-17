//
//  menuVC.swift
//  DemoAppL2
//
//  Created by Vikas Hareram Shah on 14/02/25.
//

import UIKit

class menuVC: UIViewController {

    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var changeLanguageBTN: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        updateLocalizedStrings()
    }
    
    func updateLocalizedStrings() {
        logoutBtn.setTitle("LogoutKey".localized(), for: .normal)
        changeLanguageBTN.setTitle("ChangeLanguageKey".localized(), for: .normal)
    }

    @IBAction func changelanguageBTN(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "languageVC") as! languageVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func logoutBTN(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "UserEmail")
        UserDefaults.standard.removeObject(forKey: "UserPassword")
        UserDefaults.standard.synchronize()
        
        // view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            
            // Set the root view controller to the login screen
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: loginVC)
    }
}
