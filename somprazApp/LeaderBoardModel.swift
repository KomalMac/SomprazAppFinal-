//
//  LeaderBoardModel.swift
//  somprazApp
//
//  Created by digiLATERAL on 27/10/23.
//

import Foundation
struct LeaderboardData: Codable {
    let msg: String
    let categoryLeaderboard: [DoctorInfo]
}

struct DoctorInfo: Codable {
    let doctorName: String
    let state: String
    let city: String
    let score: Int
}
