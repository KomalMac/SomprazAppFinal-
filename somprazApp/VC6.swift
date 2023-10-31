//
//  VC6.swift
//  somprazApp
//
//  Created by digiLATERAL on 18/10/23.
//

import UIKit

class VC6: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var lbImgView: UIImageView!
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var boardIV: UIImageView!
    
    @IBOutlet weak var lbLabel: UILabel!
    
    @IBOutlet weak var no3Lbl: UILabel!
    @IBOutlet weak var no2Lbl: UILabel!
    @IBOutlet weak var no1Lbl: UILabel!
    
    @IBOutlet weak var PlayedDocLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedDoctorName = ""
    var selectedDoctorID = ""
    var leaderboard = [DoctorInfo]()
    var filteredLeaderboard = [DoctorInfo]()
    var selectedCategory: String = "selectedCategory"
    var score = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        boardIV.layer.borderWidth = 2
        lbLabel.layer.borderWidth = 2
        boardIV.layer.cornerRadius = 20
        lbLabel.layer.cornerRadius = 20
        boardIV.layer.borderWidth = 2
        PlayedDocLbl.layer.cornerRadius = 20
        
        getdoctorsCategory()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        print("NewScore: \(score)")

    }
    
//    api = https://quizapi-omsn.onrender.com/api/get/leaderboard/${category}
    
    func getdoctorsCategory() {
        let category = selectedCategory
        print("Selected category: \(category)")
     
        if let url = URL(string: "https://quizapi-omsn.onrender.com/api/get/leaderboard/\(category)") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let leaderboardData = try JSONDecoder().decode(LeaderBoardModel.self, from: data)
     
                        DispatchQueue.main.async {
                            self.leaderboard = leaderboardData.categoryLeaderboard
     
                            // Sort the leaderboard in descending order based on the score
                            self.leaderboard.sort { $0.score > $1.score }
     
                            // Filter the leaderboard to include only those with a score greater than -1
                            self.filteredLeaderboard = self.leaderboard.filter { $0.score > -1 }
     
                            self.lbLabel.text = "Category: " + self.selectedCategory
                            print("Score: \(self.score)")
                            self.PlayedDocLbl.text = "\(self.selectedDoctorName), Score: \(self.score)"

                            self.tableView.reloadData()
     
                            // Update the top 3 labels
                            if self.filteredLeaderboard.count >= 3 {
                                self.no1Lbl.text = " \(self.filteredLeaderboard[0].doctorName) - \(self.filteredLeaderboard[0].score) points"
                                self.no2Lbl.text = " \(self.filteredLeaderboard[1].doctorName) - \(self.filteredLeaderboard[1].score) points"
                                self.no3Lbl.text = " \(self.filteredLeaderboard[2].doctorName) - \(self.filteredLeaderboard[2].score) points"
                            } else {
                                // Handle the case when there are not enough entries in the leaderboard
                                self.no1Lbl.text = " -"
                                self.no2Lbl.text = " -"
                                self.no3Lbl.text = " -"
                            }
                            print("Data loaded and table view reloaded. Count: \(self.leaderboard.count)")
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                } else if let error = error {
                    print("Error fetching data: \(error)")
                }
            }.resume()
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(leaderboard)
        
//        // Return the number of rows
//        return filteredLeaderboard.count
        
        // Return the number of rows starting from the 4th position
            let startIndex = 3
            return max(0, filteredLeaderboard.count - startIndex)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//           let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorTVC", for: indexPath) as! DoctorTVC
//
//           let doctorInfo = filteredLeaderboard[indexPath.row]
//           let index = indexPath.row + 4
//           cell.lblID.text = "\(doctorInfo.score) points"
//           cell.lblName.text = "\(index) " + doctorInfo.doctorName

        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorTVC", for: indexPath) as! DoctorTVC
         
            let index = indexPath.row + 4 // Start from the 4th position
            let doctorIndex = index - 1 // Adjusted index for accessing filteredLeaderboard
            if doctorIndex < filteredLeaderboard.count {
                let doctorInfo = filteredLeaderboard[doctorIndex]
                cell.lblID.text = "\(doctorInfo.score) points"
                cell.lblName.text = "\(index)    " + doctorInfo.doctorName
               
            }
         
           return cell
       }
   }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let spacingView = UIView()
        spacingView.backgroundColor = .clear
        return spacingView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10 // Adjust this value as needed
    }



