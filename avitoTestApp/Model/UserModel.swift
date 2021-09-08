//
//  UserModel.swift
//  avitoTestApp
//
//  Created by Ash on 07.09.2021.
//

import Foundation

// MARK: - UserModel
struct UserModel: Codable {
    let company: Company
}

// MARK: - Company
struct Company: Codable {
    let name: String
    let employees: [Employee]
}

// MARK: - Employee
struct Employee: Codable {
    let name, phoneNumber: String
    let skills: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}
