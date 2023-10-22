//
//  DoctorModel.swift
//  somprazApp
//
//  Created by digiLATERAL on 17/10/23.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let doctorModel = try? JSONDecoder().decode(DoctorModel.self, from: jsonData)

// MARK: - DoctorModelElement
struct DoctorModelElement: Codable {
    let quizCategory: QuizCategory
    let id: String
    let doctorName, city, state: String?
    let v: Int

    enum CodingKeys: String, CodingKey {
        case quizCategory = "QuizCategory"
        case id = "_id"
        case doctorName, city, state
        case v = "__v"
    }
}

// MARK: - QuizCategory
struct QuizCategory: Codable {
    let entertainment, astronomy, history, science: Astronomy
    let literature, geography, wildlife: Astronomy
    let technology: Technology
    let mathematics: Astronomy

    enum CodingKeys: String, CodingKey {
        case entertainment = "Entertainment"
        case astronomy = "Astronomy"
        case history = "History"
        case science = "Science"
        case literature = "Literature"
        case geography = "Geography"
        case wildlife = "Wildlife"
        case technology = "Technology"
        case mathematics = "Mathematics"
    }
}

// MARK: - Astronomy
struct Astronomy: Codable {
    let isPlayed: Bool
    let totalPoints: Int?

    enum CodingKeys: String, CodingKey {
        case isPlayed
        case totalPoints = "TotalPoints"
    }
}

// MARK: - Technology
struct Technology: Codable {
    let isPlayed: Bool
}

typealias DoctorModel = [DoctorModelElement]
