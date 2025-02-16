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
            // Set localized titles for the buttons
            logoutBtn.setTitle(NSLocalizedString("LogoutKey", comment: "Logout button text"), for: .normal)
            changeLanguageBTN.setTitle(NSLocalizedString("ChangeLanguageKey", comment: "Change Language button text"), for: .normal)
        }

    @IBAction func changelanguageBTN(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "languageVC") as! languageVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func logoutBTN(_ sender: UIButton) {
    }
}
