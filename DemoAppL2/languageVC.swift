//
//  languageVC.swift
//  DemoAppL2
//
//  Created by Vikas Hareram Shah on 14/02/25.
//

import UIKit

class languageVC: UIViewController {

    @IBOutlet weak var saveBTN: UIButton!
    @IBOutlet weak var changeLanguageLBL: UILabel!
    @IBOutlet weak var arabicST: UISwitch!
    @IBOutlet weak var englishST: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
  
        print("hello")
        // Load saved language or default to English
        let selectedLanguage = UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en"
        
        if selectedLanguage == "ar" {
            arabicST.isOn = true
            englishST.isOn = false
        } else {
            arabicST.isOn = false
            englishST.isOn = true
        }

        // Add target actions for language switch
        arabicST.addTarget(self, action: #selector(languageSwitchChanged(_:)), for: .valueChanged)
        englishST.addTarget(self, action: #selector(languageSwitchChanged(_:)), for: .valueChanged)

        // Update UI with localized strings
        updateLocalizedStrings()
    }

    @IBAction func backbtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func saveLanguageBTN(_ sender: UIButton) {
        // Save selected language
        if arabicST.isOn {
            setLanguage(language: "ar")
        } else {
            setLanguage(language: "en")
        }

        // Dismiss the view controller
        self.dismiss(animated: true, completion: nil)
    }

    func setLanguage(language: String) {
        // Save language preference
        UserDefaults.standard.set(language, forKey: "SelectedLanguage")
        UserDefaults.standard.synchronize()

        // Update UI with new language
        DispatchQueue.main.async {
            self.updateLocalizedStrings()
        }
    }

    @objc func languageSwitchChanged(_ sender: UISwitch) {
        if sender == arabicST && arabicST.isOn {
            englishST.isOn = false
        } else if sender == englishST && englishST.isOn {
            arabicST.isOn = false
        }
    }

    func updateLocalizedStrings() {
        guard let selectedLanguage = UserDefaults.standard.string(forKey: "SelectedLanguage") else {
            print("Error: No language selected in UserDefaults")
            return
        }

        saveBTN.setTitle("SaveKey".localized(), for: .normal)
        changeLanguageLBL.text = "ChangeLanguageKey".localized()
    }
}

// MARK: - Localization Extension
extension String {
    func localized() -> String {
        guard let selectedLanguage = UserDefaults.standard.string(forKey: "SelectedLanguage") else {
            return self
        }

        guard let path = Bundle.main.path(forResource: selectedLanguage, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            print("Error: Could not find localization bundle for language \(selectedLanguage)")
            return self
        }

        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: self, comment: "")
    }
}

