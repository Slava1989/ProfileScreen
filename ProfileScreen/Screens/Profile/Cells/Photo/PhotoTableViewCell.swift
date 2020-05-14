//
//  PhotoTableViewCell.swift
//  ProfileScreen
//
//  Created by Veaceslav Chirita on 5/13/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var editImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 50
        containerView.layer.masksToBounds = true
        
//        editImageView.layer.cornerRadius = 15
//        editImageView.layer.masksToBounds = true
        
        photoImageView.layer.cornerRadius = 50
        photoImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.backgroundColor = .clear
        } else {
            self.backgroundColor = .clear
        }
    }
}

extension PhotoTableViewCell: AVPhotoSender {
    func sendImage(_ image: UIImage) {
        photoImageView.image = image
    }
}
