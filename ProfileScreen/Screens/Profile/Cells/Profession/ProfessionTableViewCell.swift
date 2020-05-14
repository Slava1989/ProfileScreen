//
//  ProfessionTableViewCell.swift
//  ProfileScreen
//
//  Created by Veaceslav Chirita on 5/13/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit

protocol CountryFlagDelegate: class {
    func didTapOnFlag()
}

class ProfessionTableViewCell: UITableViewCell {
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var phoneContainerView: UIView!
    @IBOutlet weak var professionLabel: UILabel!
    @IBOutlet weak var professionTextView: UITextView!
    @IBOutlet weak var professionContainer: UIView!
    
    private var phoneIsSet = true
    private var emailIsSet = false
    var delegate: CountryFlagDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        countryButton.setTitle(emojiFlag(regionCode: "NL")!, for: .normal)
        phoneView.layer.cornerRadius = 10
        phoneView.layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.4784313725, blue: 0.4156862745, alpha: 1)
        phoneView.layer.borderWidth = 1
        phoneView.layer.masksToBounds = true
        
        emailView.layer.cornerRadius = 10
        emailView.layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.4784313725, blue: 0.4156862745, alpha: 1)
        emailView.layer.borderWidth = 1
        emailView.layer.masksToBounds = true
        
        let phoneTap = UITapGestureRecognizer(target: self, action: #selector(phoneTapped))
        phoneView.addGestureRecognizer(phoneTap)
        phoneView.isUserInteractionEnabled = true
        
        let emailTap = UITapGestureRecognizer(target: self, action: #selector(emailTapped))
        emailView.addGestureRecognizer(emailTap)
        emailView.isUserInteractionEnabled = true
        
        phoneView.backgroundColor = #colorLiteral(red: 0.9572998881, green: 0.5615186095, blue: 0.4897431135, alpha: 1)
        emailView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    override func prepareForReuse() {
        professionLabel.text = ""
    }
    
    func emojiFlag(regionCode: String) -> String? {
        let code = regionCode.uppercased()
        
        guard Locale.isoRegionCodes.contains(code) else {
            return nil
        }
        
        var flagString = ""
        for s in code.unicodeScalars {
            guard let scalar = UnicodeScalar(127397 + s.value) else {
                continue
            }
            flagString.append(String(scalar))
        }
        return flagString
    }
    
    @objc func phoneTapped() {
        phoneIsSet = true
        emailIsSet = false
        
        phoneView.backgroundColor = #colorLiteral(red: 0.9572998881, green: 0.5615186095, blue: 0.4897431135, alpha: 1)
        emailView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    @objc func emailTapped() {
        emailIsSet = true
        phoneIsSet = false
        
        emailView.backgroundColor = #colorLiteral(red: 0.9572998881, green: 0.5615186095, blue: 0.4897431135, alpha: 1)
        phoneView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func setFlagButton(region: String?) {
        if region == nil {
            return
        }
        
        countryButton.setTitle(emojiFlag(regionCode: region!), for: .normal)
    }
    
    @IBAction func didTapOnCountryButton(_ sender: UIButton) {
        delegate.didTapOnFlag()
    }
}
