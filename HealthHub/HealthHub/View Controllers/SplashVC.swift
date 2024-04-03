//
//  SplashVC.swift
//  HealthHub
//
//  Created by Dawinder on 03/04/24.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check user login status after 2 seconds
        if let doctor_id = UserDefaults.standard.string(forKey: "doctorID") {
            print("Doctor ID:", doctorID)
            doctorID = doctor_id
        }
        
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(checkUserLoggedIn), userInfo: nil, repeats: false)
    }
    
    @objc func checkUserLoggedIn() {
        let userLoggedIn = UserDefaults.standard.bool(forKey: "userLoggedIn")
        if userLoggedIn {
            goToRootHome()
        } else {
            goToLogin()
        }
    }
    
    func goToRootHome() {
        // Instantiate TabbarViewController from Main storyboard
        if let tabbarVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabbarViewController") as? TabbarViewController {
            navigationController?.setViewControllers([tabbarVC], animated: true)
        }
    }
    
    func goToLogin() {
        // Instantiate ViewController from Main storyboard
        if let loginVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            navigationController?.setViewControllers([loginVC], animated: true)
        }
    }
}

