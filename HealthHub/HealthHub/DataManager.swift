//
//  DataManager.swift
//  HealthHub
//
//  Created by Dawinder on 02/04/24.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private var patientData: [String: [Patient]] = [:]
    private var bloodTestReports: [String: [BloodTestReport]] = [:]
    
    private init() {
        // Load patient data from UserDefaults when the class is initialized
        if let data = UserDefaults.standard.data(forKey: "patientData"),
           let savedPatients = try? JSONDecoder().decode([String: [Patient]].self, from: data) {
            patientData = savedPatients
        }
        
        if let data = UserDefaults.standard.data(forKey: "bloodTestReports"),
           let savedBloodTestReports = try? JSONDecoder().decode([String: [BloodTestReport]].self, from: data) {
            bloodTestReports = savedBloodTestReports
        }
    }
    
    func getPatients(forKey key: String) -> [Patient]? {
        return patientData[key]
    }
    
    func getBloodTest(forKey key: String) -> [BloodTestReport]? {
        return bloodTestReports[key]
    }
    
    func addPatient(_ patient: Patient, forKey key: String) {
        if var patients = patientData[key] {
            patients.append(patient)
            patientData[key] = patients
        } else {
            patientData[key] = [patient]
        }
        savePatients()
    }
    
    func addBloodTest(_ test: BloodTestReport, toPatientWithName name: String, forKey key: String) {
        if var bloodTests = bloodTestReports[name] {
            bloodTests.append(test)
            bloodTestReports[name] = bloodTests
        } else {
            bloodTestReports[name] = [test]
        }
        saveBloodTestReports()
    }
    
    private func savePatients() {
        let encodedData = try? JSONEncoder().encode(patientData)
        UserDefaults.standard.set(encodedData, forKey: "patientData")
    }
    
    private func saveBloodTestReports() {
        let encodedData = try? JSONEncoder().encode(bloodTestReports)
        UserDefaults.standard.set(encodedData, forKey: "bloodTestReports")
    }
}
