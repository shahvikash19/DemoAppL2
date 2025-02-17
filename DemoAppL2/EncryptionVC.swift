//
//  EncryptionVC.swift
//  DemoAppL2
//
//  Created by Vikas Hareram Shah on 13/02/25.
//


import UIKit

class EncryptionVC: UIViewController {

    @IBOutlet weak var decBTN: UIButton!
    @IBOutlet weak var encBTN: UIButton!
    @IBOutlet weak var welcomeLBL: UILabel!
    
    
    @IBOutlet weak var showlbl: UILabel!
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(true, animated: false)

        setupCopyableLabel()
        updateLocalizedStrings()
    }
    
    func updateLocalizedStrings() {
        // Update button titles using the localized() extension
        decBTN.setTitle("DecryptKey".localized(), for: .normal)
        encBTN.setTitle("EncryptKey".localized(), for: .normal)
        
        // Update label text
        welcomeLBL.text = "welcomeKey".localized()
    }


    @IBAction func menuBTN(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "menuVC") as! menuVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func encryptedBTN(_ sender: UIButton) {

        guard let text = textfield1.text, !text.isEmpty,
                  let key = textfield2.text, !key.isEmpty else {
                showlbl.text = "Please enter both text and secret key."
                return
            }

            if let encryptedText = encryptAES(text: text, key: key) {
                showlbl.text = "Encrypted: \(encryptedText)"
                print("Encrypted: \(encryptedText)")
                textfield1.text = ""
            } else {
                showlbl.text = "Encryption failed."
            }
    }

    @IBAction func decryptedBTN(_ sender: UIButton) {
        guard let encryptedText = textfield1.text, !encryptedText.isEmpty,
                  let key = textfield2.text, !key.isEmpty else {
                showlbl.text = "Please enter both encrypted text and secret key."
                return
            }

            if let decryptedText = decryptAES(text: encryptedText, key: key) {
                showlbl.text = "Decrypted: \(decryptedText)"
                print("Decrypted: \(decryptedText)")
                
            } else {
                showlbl.text = "Decryption failed."
                print("Decryption failed.")
            }
    }
    
    // MARK: - Make Label Copyable
    func setupCopyableLabel() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(copyLabelText))
        showlbl.isUserInteractionEnabled = true
        showlbl.addGestureRecognizer(longPressGesture)
    }

    @objc func copyLabelText() {
        UIPasteboard.general.string = showlbl.text
        let alert = UIAlertController(title: "Copied", message: "Text copied to clipboard.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
