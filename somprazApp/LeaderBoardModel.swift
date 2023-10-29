//
//  LeaderBoardModel.swift
//  somprazApp
//
//  Created by digiLATERAL on 27/10/23.
//

import Foundation

// MARK: - LeaderBoardModel
struct LeaderBoardModel: Codable {
    let msg: String
    let categoryLeaderboard: [DoctorInfo]
}

// MARK: - CategoryLeaderboard
struct DoctorInfo: Codable {
    let doctorName, state: String
    let city: String?
    let score: Int
}
