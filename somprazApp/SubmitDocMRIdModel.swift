//
//  SubmitDocMRIdModel.swift
//  somprazApp
//
//  Created by digiLATERAL on 01/12/23.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let submitDocMRID = try? JSONDecoder().decode(SubmitDocMRID.self, from: jsonData)


// MARK: - SubmitDocMRIDElement
struct SubmitDocMRIDElement: Codable {
    let id, doctorName: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case doctorName
    }
}

typealias SubmitDocMRID = [SubmitDocMRIDElement]
