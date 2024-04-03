//
//  AddTestsVC.swift
//  HealthHub
//
//  Created by Dawinder on 01/04/24.
//

import UIKit

class AddTestsVC: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var resultTV: UITextView!
    @IBOutlet weak var collectionDate: UIDatePicker!
    
    weak var delegate: AddTestDelegate?
    let dataManager = DataManager.shared
    var patientObj : Patient?
    
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTV.layer.borderWidth = 1
        resultTV.layer.cornerRadius = 12
        resultTV.layer.borderColor = UIColor.systemGray5.cgColor
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                
                // Add activity indicator to the view
        view.addSubview(activityIndicator)
                
                // Center activity indicator in the view
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
                
                // Hide the activity indic
    }
    
    @IBAction func crossBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func confirmBtn(_ sender: UIButton) {
        activityIndicator.startAnimating()
        guard let name = nameTF.text,
              let result = resultTV.text else {
            return
        }
        let date = formatDate(collectionDate.date)
        let blood = BloodTestReport(date: date, testName: name, result: result)
        dataManager.addBloodTest(blood, toPatientWithName: patientObj?.name ?? "", forKey: patientObj?.name ?? "")
        delegate?.didAddTest(blood: blood)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.activityIndicator.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") // Set time zone to UTC
            
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
}
