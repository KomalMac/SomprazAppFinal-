//
//  AddDocModel.swift
//  somprazApp
//
//  Created by digiLATERAL on 30/11/23.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let addDocModel = try? JSONDecoder().decode(AddDocModel.self, from: jsonData)


// MARK: - AddDocModel
struct AddDocModel: Codable {
    let doctorName, state, mrID: String
    let message, id: String

    enum CodingKeys: String, CodingKey {
        case doctorName, state
        case mrID = "mrId"
        case message
        case id = "Id"
    }
}
