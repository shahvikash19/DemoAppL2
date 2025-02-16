//
//  ToDoVC.swift
//  DemoAppL2
//
//  Created by Vikas Hareram Shah on 13/02/25.
//

import UIKit

class ToDoVC: UIViewController {
    
    @IBOutlet weak var wlecomeLBL: UILabel!
    
    @IBOutlet weak var tableview: UITableView!

    var tasks: [(taskName: String, dateTime: Date)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(true, animated: false)

        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "taskTVC", bundle: nil), forCellReuseIdentifier: "taskTVC")

        // Load tasks from UserDefaults
        loadTasks()

        // Floating Action Button setup
        let fabButton = UIButton(type: .system)
        fabButton.frame = CGRect(x: self.view.frame.width - 80, y: self.view.frame.height - 150, width: 60, height: 60)
        fabButton.backgroundColor = .systemBackground
        fabButton.setTitle("+", for: .normal)
        fabButton.tintColor = .black
        fabButton.layer.borderColor = UIColor.black.cgColor
        fabButton.layer.borderWidth = 2
        fabButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        fabButton.layer.cornerRadius = fabButton.frame.size.width / 2
        fabButton.addTarget(self, action: #selector(AddtaskBTN(_:)), for: .touchUpInside)
        self.view.addSubview(fabButton)
    }

    @objc func AddtaskBTN(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TaskVC") as! TaskVC
        vc.delegate = self // Pass the ToDoVC instance as delegate to update the tasks list
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

    @IBAction func menu2BTN(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "menuVC") as! menuVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
    }
    
    // Load tasks from UserDefaults
    func loadTasks() {
        if let savedTasks = UserDefaults.standard.array(forKey: "tasks") as? [[String: Any]] {
            tasks = savedTasks.compactMap { dict in
                if let taskName = dict["taskName"] as? String,
                   let dateTime = dict["dateTime"] as? Date {
                    return (taskName, dateTime)
                }
                return nil
            }
            tableview.reloadData()
        }
    }

    // Save tasks to UserDefaults
    func saveTasks() {
        let tasksToSave = tasks.map { task -> [String: Any] in
            return ["taskName": task.taskName, "dateTime": task.dateTime]
        }
        UserDefaults.standard.set(tasksToSave, forKey: "tasks")
    }
    
    
}

extension ToDoVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskTVC", for: indexPath) as! taskTVC
        let task = tasks[indexPath.row]
        cell.configureCell(task: task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }

    // Swipe to delete task
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Create an alert to confirm the deletion
                let alert = UIAlertController(title: "Are you sure?", message: "You want to delete this task?", preferredStyle: .alert)
                
                // Add a Cancel action
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                // Add a Delete action
                alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
                    // Perform deletion if user taps OK
                    self.tasks.remove(at: indexPath.row)
                    self.saveTasks()  // Save tasks after deletion
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }))
                
                // Present the alert
                present(alert, animated: true, completion: nil)
            }
        }
    }

extension ToDoVC: TaskVCDelegate {
    func didSaveTask(task: (String, Date)) {
        tasks.append(task)
        saveTasks()  // Save tasks after adding a new task
        tableview.reloadData()
    }
}
