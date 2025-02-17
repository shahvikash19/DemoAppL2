//
//  TaskVC.swift
//  DemoAppL2
//
//  Created by Vikas Hareram Shah on 14/02/25.
//


import UIKit

protocol TaskVCDelegate: AnyObject {
    func didSaveTask(task: (String, Date))
}

class TaskVC: UIViewController {
    
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    @IBOutlet weak var addTaskTF: UITextField!
    
    @IBOutlet weak var clrBTN: UIButton!
    @IBOutlet weak var saveBTN: UIButton!
    @IBOutlet weak var addtaskLBL: UILabel!
    
    
    weak var delegate: TaskVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        updateLocalizedStrings()
    }
    
    func updateLocalizedStrings() {
        clrBTN.setTitle("ClearKey".localized(), for: .normal)
        saveBTN.setTitle("SaveKey".localized(), for: .normal)
        addtaskLBL.text = "AddTaskKey".localized()
        
        if let selectedLanguage = UserDefaults.standard.string(forKey: "SelectedLanguage") {
                if selectedLanguage == "ar" {
                    dateTimePicker.locale = Locale(identifier: "ar")  // Arabic
                } else {
                    dateTimePicker.locale = Locale(identifier: "en")  // English
                }
            }
    }


    @IBAction func saveBtnTapped(_ sender: UIButton) {
        guard let taskName = addTaskTF.text, !taskName.isEmpty else {
            // Show an alert or some error message if the task name is empty
            let alert = UIAlertController(title: "Error", message: "Please enter a task name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let taskDate = dateTimePicker.date
        delegate?.didSaveTask(task: (taskName, taskDate))
        navigationController?.popViewController(animated: true)
    }

    @IBAction func clearBtnTapped(_ sender: UIButton) {
        addTaskTF.text = ""
        dateTimePicker.date = Date()  // Reset to the current date
    }

    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
