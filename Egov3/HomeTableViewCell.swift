//
//  HomeTableViewCell.swift
//  Egov3
//
//  Created by Saltanat Aimakhanova on 6/24/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet var email: UILabel!
    @IBOutlet var contactnumber: UILabel!
    @IBOutlet var headname: UILabel!
    @IBOutlet var schedule: UITextView!
    @IBOutlet var address: UILabel!
    @IBOutlet var services: UITextView!
    @IBOutlet var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
