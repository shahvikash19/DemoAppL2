//
//  stopWatchVC.swift
//  DemoAppL2
//
//  Created by Vikas Hareram Shah on 13/02/25.
//

import UIKit

class stopWatchVC: UIViewController {

    @IBOutlet weak var welcomeLBL: UILabel!
    
    @IBOutlet weak var timeLBL: UILabel!
    @IBOutlet weak var timeview: UIView!

    var timer: Timer?
    var elapsedTime: TimeInterval = 0
    var isRunning = false
    var startTime: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(true, animated: false)

        updateLabel()
        setupTimeView()
        updateLocalizedStrings()
    }
    
    func setupTimeView() {
        timeview.layer.cornerRadius = timeview.frame.size.width / 2
        timeview.layer.masksToBounds = true
        timeview.layer.borderColor = UIColor.black.cgColor
        timeview.layer.borderWidth = 2
    }
    
    func updateLocalizedStrings() {
            welcomeLBL.text = NSLocalizedString("welcomeKey", comment: "Welcome label text")
        }

    @IBAction func menu3BTN(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "menuVC") as! menuVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func playBtnTapped(_ sender: UIButton) {
        guard !isRunning else { return }  // Prevent multiple timers from starting
        isRunning = true
        startTime = Date() - elapsedTime  // Resume from where paused
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.updateLabel()
        }
    }

    @IBAction func pausBtnTapped(_ sender: UIButton) {
        guard isRunning else { return }
        isRunning = false
        elapsedTime = Date().timeIntervalSince(startTime ?? Date())
        timer?.invalidate()
        timer = nil
    }

    @IBAction func stopBTNTapped(_ sender: UIButton) {
        isRunning = false
        timer?.invalidate()
        timer = nil
        elapsedTime = 0
        updateLabel()
    }

    // MARK: - Update Timer Label
    func updateLabel() {
        let totalSeconds = Int(elapsedTime)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        timeLBL.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        
        if isRunning {
            elapsedTime = Date().timeIntervalSince(startTime ?? Date())
        }
    }
}
