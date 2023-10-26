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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        boardIV.layer.borderWidth = 2
        lbLabel.layer.borderWidth = 2
        boardIV.layer.cornerRadius = 20
        lbLabel.layer.cornerRadius = 20
        
       // add print mesage
        tableView.backgroundColor = .blue
        tableView.separatorColor = UIColor.gray // Set your desired color

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorTVC", for: indexPath) as! DoctorTVC

        // Configure your cell
        cell.lblID.text = "ID :" + selectedDoctorID
        cell.lblName.text = "Name :" + selectedDoctorName
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = 100 // Adjust this value to your content size
        let spaceHeight = 10 // Adjust this value to the desired space
        return CGFloat(cellHeight + spaceHeight)
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
