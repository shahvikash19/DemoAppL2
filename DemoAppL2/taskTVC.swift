//
//  taskTVC.swift
//  DemoAppL2
//
//  Created by Vikas Hareram Shah on 14/02/25.
//

import UIKit

class taskTVC: UITableViewCell {

    @IBOutlet weak var dateTimeLBL: UILabel!  
    @IBOutlet weak var taskNameLBL: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // Configure cell with task data
    func configureCell(task: (taskName: String, dateTime: Date)) {
        taskNameLBL.text = task.taskName
        
        let selectedLanguage = UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en"
                
        
        // Format date and time together into one string
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        if selectedLanguage == "ar" {
                    dateFormatter.locale = Locale(identifier: "ar")
                } else {
                    dateFormatter.locale = Locale(identifier: "en")
                }
        
        // Display both date and time in dateTimeLBL
        dateTimeLBL.text = dateFormatter.string(from: task.dateTime)
    }
}
