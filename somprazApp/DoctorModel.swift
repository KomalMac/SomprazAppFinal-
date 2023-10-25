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

//// MARK: - DoctorModelElement
//struct DoctorModelElement: Codable {
//    let quizCategory: QuizCategory?
//    let id: String?
//    let doctorName, city, state: String?
//    let v: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case quizCategory = "QuizCategory"
//        case id = "_id"
//        case doctorName, city, state
//        case v = "__v"
//    }
//}
//
//// MARK: - QuizCategory
struct QuizCategory: Codable {
    let entertainment, astronomy, history, science, literature, geography, wildlife, technology, mathematics: playedInfo?

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
//
//// MARK: - Astronomy
struct playedInfo: Codable {
    let isPlayed: Bool
    let totalPoints: Int?

    enum CodingKeys: String, CodingKey {
        case isPlayed
        case totalPoints = "TotalPoints"
    }
}
//
//typealias DoctorModel = [DoctorModelElement]




typealias doctorModelNew = [QuizCategory]




struct DoctorModelElement: Codable {
    let entertainment: Astronomy?
    let astronomy, history, science, literature: Astronomy?
    let geography: Astronomy?
    let wildlife, technology: Entertainment?
    let mathematics: Astronomy?

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

// MARK: - Entertainment
struct Entertainment: Codable {
    let isPlayed: Bool
}

typealias DoctorModel = [DoctorModelElement]



//RESPONSE
//
//
//[{"category":"Entertainment","isPlayed":false},
//{"category" :"Astronomy","isPlayed":true,"TotalPoints":10},
//{"category" :"History","isPlayed":true,"TotalPoints":10},
//{"category" :"Science","isPlayed":true,"TotalPoints":10},
//{"category" :"Literature","isPlayed":true,"TotalPoints":10},
//{"category" :"Geography","isPlayed":true,"TotalPoints":20},
//{"category" :"Wildlife","isPlayed":true,"TotalPoints":10},
//{"category" :"Technology","isPlayed":true,"TotalPoints":20},
//{"category" :"Mathematics","isPlayed":true,"TotalPoints":30}]
