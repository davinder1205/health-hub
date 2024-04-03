//
//  ViewController.swift
//  HealthHub
//
//  Created by Dawinder on 01/04/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var idTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        idTF.delegate = self
    }

    @IBAction func startedBtn(_ sender: UIButton) {
        
        if idTF.text?.isEmpty ?? true{
            return
        }
        UserDefaults.standard.set(true, forKey: "userLoggedIn")
        doctorID = idTF.text ?? ""
        UserDefaults.standard.set(doctorID, forKey: "doctorID")
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text: NSString = (textField.text ?? "") as NSString
        let resultString = text.replacingCharacters(in: range, with: string)
        
        if resultString.count > 6{
            return false
        }

        return true
    }
    
}

