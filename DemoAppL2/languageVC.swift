//
//  languageVC.swift
//  DemoAppL2
//
//  Created by Vikas Hareram Shah on 14/02/25.
//

import UIKit

class languageVC: UIViewController {

//    @IBOutlet weak var saveButton: UIButton!
//    @IBOutlet weak var changeLanguageLabel: UILabel!
//    @IBOutlet weak var arabicSwitch: UISwitch!
//    @IBOutlet weak var englishSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var englishSwitch: UISwitch!
    @IBOutlet weak var changeLanguageLabel: UILabel!
    @IBOutlet weak var arabicSwitch: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLanguageSelection()
        setupLanguageSwitchActions()
        updateLocalizedStrings()
    }

    private func setupLanguageSelection() {
        let selectedLanguage = UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en"
        arabicSwitch.isOn = (selectedLanguage == "ar")
        englishSwitch.isOn = (selectedLanguage == "en")
    }

    private func setupLanguageSwitchActions() {
        arabicSwitch.addTarget(self, action: #selector(languageSwitchChanged(_:)), for: .valueChanged)
        englishSwitch.addTarget(self, action: #selector(languageSwitchChanged(_:)), for: .valueChanged)
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveLanguageButtonTapped(_ sender: UIButton) {
        let selectedLanguage = arabicSwitch.isOn ? "ar" : "en"
        setLanguage(language: selectedLanguage)
        resetApp()
    }

    private func setLanguage(language: String) {
        UserDefaults.standard.set(language, forKey: "SelectedLanguage")
        UserDefaults.standard.synchronize()
    }

    @objc private func languageSwitchChanged(_ sender: UISwitch) {
        if sender == arabicSwitch && arabicSwitch.isOn {
            englishSwitch.isOn = false
        } else if sender == englishSwitch && englishSwitch.isOn {
            arabicSwitch.isOn = false
        }
    }

    private func updateLocalizedStrings() {
        saveButton.setTitle("SaveKey".localized(), for: .normal)
        changeLanguageLabel.text = "ChangeLanguageKey".localized()
    }

    private func resetApp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let rootViewController = storyboard.instantiateInitialViewController() {
            UIApplication.shared.windows.first?.rootViewController = rootViewController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
}

extension String {
    func localized() -> String {
        let selectedLanguage = UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en"
        guard let path = Bundle.main.path(forResource: selectedLanguage, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            print("Error: Could not find localization bundle for language \(selectedLanguage)")
            return self
        }
        return NSLocalizedString(self, tableName: "Localizable1", bundle: bundle, value: self, comment: "")
    }
}
