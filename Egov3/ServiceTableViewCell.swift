//
//  ServiceTableViewCell.swift
//  Egov3
//
//  Created by Saltanat Aimakhanova on 6/23/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {

    @IBOutlet var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet var myImage: UIImageView!

}
