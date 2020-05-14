//
//  UserDataTableViewCell.swift
//  ProfileScreen
//
//  Created by Veaceslav Chirita on 5/13/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit

class UserDataTableViewCell: UITableViewCell {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
//        nameTextField.text = ""
//        userNameTextField.text = ""
//        emailTextField.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
