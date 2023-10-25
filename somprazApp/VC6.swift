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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        boardIV.layer.borderWidth = 2
        lbLabel.layer.borderWidth = 2
        boardIV.layer.cornerRadius = 20
        lbLabel.layer.cornerRadius = 20
        
       // add print mesage
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return imageArray.count
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorTVC", for: indexPath) as! DoctorTVC
            
//            // Set the background color of the cell's contentView to blue
//            cell.contentView.backgroundColor = UIColor.lightGray
            
            // Configure the cell's other properties (text, images, etc.) here
        // Set the separator insets
            cell.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            return cell
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Adjust this value as needed
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 1
        let headerView = UIView()
        // 2
        headerView.backgroundColor = view.backgroundColor
        // 3
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

}
