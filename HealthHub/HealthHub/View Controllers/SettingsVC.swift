//
//  SettingsVC.swift
//  HealthHub
//
//  Created by Dawinder on 02/04/24.
//

import UIKit

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logoutBtn(_ sender: UIButton) {
        doctorID = ""
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
