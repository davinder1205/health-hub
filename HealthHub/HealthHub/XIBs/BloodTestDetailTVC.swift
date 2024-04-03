//
//  BloodTestDetailTVC.swift
//  HealthHub
//
//  Created by Dawinder on 02/04/24.
//

import UIKit

class BloodTestDetailTVC: UITableViewCell {

    @IBOutlet weak var testHeadLbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var testName: UILabel!
    @IBOutlet weak var detailView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
