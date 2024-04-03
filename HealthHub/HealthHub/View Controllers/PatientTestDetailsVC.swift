//
//  PatientTestDetailsVC.swift
//  HealthHub
//
//  Created by Dawinder on 01/04/24.
//

import UIKit

protocol AddTestDelegate: AnyObject {
    func didAddTest(blood: BloodTestReport)
}

class PatientTestDetailsVC: UIViewController {
    
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            let nib = UINib(nibName: "BloodTestDetailTVC", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "BloodTestDetailTVC")
        }
    }
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    
    var patientObj : Patient?
    var bloodTestList : [BloodTestReport] = []
    let dataManager = DataManager.shared
    
    var selectedInd : Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = "Patient name:  \(patientObj?.name ?? "")"
        ageLbl.text = "Age:  \(patientObj?.age ?? 0)"
        genderLbl.text = "Gender:  \(patientObj?.gender ?? "")"
        dateLbl.text = "Date of visit:  \(patientObj?.visitDate ?? "")"
        bloodTestList = dataManager.getBloodTest(forKey: patientObj?.name ?? "") ?? []
        if bloodTestList.count > 0{
            noDataView.isHidden = true
        }else{
            noDataView.isHidden = false
        }
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func addTestBtn(_ sender: UIButton) {
        let addPatientVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddTestsVC") as! AddTestsVC
        addPatientVC.delegate = self
        addPatientVC.modalPresentationStyle = .overFullScreen
        addPatientVC.patientObj = self.patientObj
        present(addPatientVC, animated: true, completion: nil)
    }
    
}

extension PatientTestDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bloodTestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BloodTestDetailTVC", for: indexPath) as! BloodTestDetailTVC
        let blood = bloodTestList[indexPath.row]
        cell.testHeadLbl.text = blood.testName
        cell.testName.text = "Test name:  \(blood.testName)"
        cell.dateLbl.text = "Date:  \(blood.date)"
        cell.resultLbl.text = "Result:  \(blood.result)"
        if selectedInd == indexPath.row{
            cell.detailView.isHidden = false
        }else{
            cell.detailView.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedInd == indexPath.row{
            selectedInd = -1
        }else{
            selectedInd = indexPath.row
        }
        self.tableView.reloadData()
    }
}

extension PatientTestDetailsVC: AddTestDelegate {
    func didAddTest(blood: BloodTestReport) {
        bloodTestList.append(blood)
        if bloodTestList.count > 0{
            noDataView.isHidden = true
        }else{
            noDataView.isHidden = false
        }
        tableView.reloadData()
    }
}
