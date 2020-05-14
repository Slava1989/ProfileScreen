//
//  FlagViewController.swift
//  ProfileScreen
//
//  Created by Veaceslav Chirita on 5/14/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit

protocol SelectFlagDelegate: class {
    func didChoseFlag(region: String)
}

class FlagViewController: UIViewController {

    @IBOutlet private var flagTableView: UITableView!
    var selectFlagDelegate: SelectFlagDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        flagTableView.dataSource = self
        flagTableView.delegate = self
        
        flagTableView.register(UINib(nibName: "FlagTableViewCell", bundle: nil), forCellReuseIdentifier: "FlagTableViewCell")
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
}

extension FlagViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectFlagDelegate.didChoseFlag(region: Locale.isoRegionCodes[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}

extension FlagViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Locale.isoRegionCodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = flagTableView.dequeueReusableCell(withIdentifier: "FlagTableViewCell", for: indexPath) as? FlagTableViewCell else {
            return UITableViewCell()
        }
        
        let regionCode = Locale.isoRegionCodes[indexPath.row]
        cell.countryCodeLabel.text = regionCode
        cell.flagLabel.text = emojiFlag(regionCode: regionCode)
        return cell
    }
    
    
}
