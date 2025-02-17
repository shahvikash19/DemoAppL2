//
//  ViewController2.swift
//  DemoAppL2
//
//  Created by Vikas Hareram Shah on 13/02/25.
//

import UIKit

class ViewController2: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            updateLocalizedStrings()
        }
    func updateLocalizedStrings() {
            if let tabBarItems = tabBar.items {
                if tabBarItems.count > 0 {
                    tabBarItems[0].title = "ToDoKey".localized()
                }
                if tabBarItems.count > 1 {
                    tabBarItems[1].title = "StopwatchKey".localized()
                }
                if tabBarItems.count > 2 {
                    tabBarItems[2].title = "EncryptKey".localized()
                }
            }

            DispatchQueue.main.async {
                self.tabBar.setNeedsLayout()
            }
        }
}

