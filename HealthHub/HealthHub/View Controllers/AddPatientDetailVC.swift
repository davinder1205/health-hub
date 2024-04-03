//
//  AddPatientDetailVC.swift
//  HealthHub
//
//  Created by Dawinder on 01/04/24.
//

import UIKit

class AddPatientDetailVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var dateOfVisitDatePicker: UIDatePicker!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    
    weak var delegate: AddPatientDelegate?
    let dataManager = DataManager.shared
    
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageTF.delegate = self
        dateOfVisitDatePicker.datePickerMode = .date
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
                
                // Hide the activity indicator initially
        activityIndicator.stopAnimating()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text: NSString = (textField.text ?? "") as NSString
        let resultString = text.replacingCharacters(in: range, with: string)
        
        if resultString.count > 2{
            return false
        }

        return true
    }
    
    @IBAction func crossBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        activityIndicator.startAnimating()
            guard let name = nameTF.text,
                  let ageString = ageTF.text,
                  let age = Int(ageString),
                  let gender = genderSegmentedControl.titleForSegment(at: genderSegmentedControl.selectedSegmentIndex) else {
                return
            }
        
        let dateOfVisit = formatDate(dateOfVisitDatePicker.date)
        let patient = Patient(name: name, age: age, gender: gender, visitDate: "\(dateOfVisit)")
        dataManager.addPatient(patient, forKey: doctorID)
        delegate?.didAddPatient(patient: patient)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.activityIndicator.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
    }
        
        @IBAction func cancelButtonTapped(_ sender: UIButton) {
            dismiss(animated: true, completion: nil)
        }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") // Set time zone to UTC
            
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
}
