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
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedDoctorName = ""
    var selectedDoctorID = ""
    var leaderboard = [DoctorInfo]()
    var selectedCategory: String = "selectedCategory"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        boardIV.layer.borderWidth = 2
        lbLabel.layer.borderWidth = 2
        boardIV.layer.cornerRadius = 20
        lbLabel.layer.cornerRadius = 20
        getdoctorsCategory()
        
        tableView.delegate = self
        tableView.dataSource = self

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
                        // Update the UI on the main thread
                        // Update the UI on the main thread
                        DispatchQueue.main.async {
                            self.leaderboard = [DoctorInfo]()
                            self.leaderboard = leaderboardData.categoryLeaderboard
                            self.lbLabel.text = "Category: " + self.selectedCategory // Update lbLabel
                            self.tableView.reloadData()
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
        // Return the number of rows
        return leaderboard.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorTVC", for: indexPath) as! DoctorTVC

            let doctorInfo = leaderboard[indexPath.row]
            cell.lblID.text = "Doctor Name: " + doctorInfo.doctorName
            cell.lblName.text = "City: " + (doctorInfo.city ?? "")
            // You can display other information like state and score as needed

            return cell
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let spacingView = UIView()
        spacingView.backgroundColor = .clear
        return spacingView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10 // Adjust this value as needed
    }


}
