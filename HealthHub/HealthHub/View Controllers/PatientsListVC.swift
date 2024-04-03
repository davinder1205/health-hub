//
//  PatientsListVC.swift
//  HealthHub
//
//  Created by Dawinder on 01/04/24.
//

import UIKit

protocol AddPatientDelegate: AnyObject {
    func didAddPatient(patient: Patient)
}

var doctorID : String = ""

class PatientsListVC: UIViewController {
    
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            let nib = UINib(nibName: "PAtientListTVC", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "PAtientListTVC")
        }
    }
    
    var patients: [Patient] = []
    let dataManager = DataManager.shared
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Patients"
        
        patients = dataManager.getPatients(forKey: doctorID) ?? []
        if patients.count > 0{
            noDataView.isHidden = true
        }else{
            noDataView.isHidden = false
        }
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let addPatientVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddPatientDetailVC") as! AddPatientDetailVC
        addPatientVC.delegate = self
        addPatientVC.modalPresentationStyle = .overFullScreen
        present(addPatientVC, animated: true, completion: nil)
    }
    
}
extension PatientsListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PAtientListTVC", for: indexPath) as! PAtientListTVC
        let patient = patients[indexPath.row]
        cell.nameLbl.text = patient.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PatientTestDetailsVC") as! PatientTestDetailsVC
        vc.patientObj = patients[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PatientsListVC: AddPatientDelegate {
    func didAddPatient(patient: Patient) {
        patients.append(patient)
        if patients.count > 0{
            noDataView.isHidden = true
        }else{
            noDataView.isHidden = false
        }
        tableView.reloadData()
    }
}
