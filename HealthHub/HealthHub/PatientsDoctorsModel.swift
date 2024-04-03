//
//  PatientsDoctorsModel.swift
//  HealthHub
//
//  Created by Dawinder on 01/04/24.
//

import Foundation

struct BloodTestReport : Codable{
    let date: String
    let testName: String
    let result: String
}

struct Patient : Codable{
    let name: String
    let age: Int
    let gender: String
    let visitDate: String
    var bloodTestReports: [BloodTestReport] = []// List of blood test reports for the patient
}

