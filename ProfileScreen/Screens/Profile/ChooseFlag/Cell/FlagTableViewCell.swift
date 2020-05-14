//
//  FlagTableViewCell.swift
//  ProfileScreen
//
//  Created by Veaceslav Chirita on 5/14/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit

class FlagTableViewCell: UITableViewCell {

    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var flagLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        countryCodeLabel.text = ""
        flagLabel.text = ""
    }
}
