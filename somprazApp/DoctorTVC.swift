//
//  DoctorTVC.swift
//  somprazApp
//
//  Created by digiLATERAL on 18/10/23.
//

import UIKit

class DoctorTVC: UITableViewCell {
    

    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Set a clear background color
                self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCellSpacing(top: CGFloat, bottom: CGFloat) {
            cellView.layoutMargins = UIEdgeInsets(top: top, left: 0, bottom: bottom, right: 0)
        }

}
