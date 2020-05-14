//
//  ProfileViewController.swift
//  ProfileScreen
//
//  Created by Veaceslav Chirita on 5/13/20.
//  Copyright (c) 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit

protocol ProfileDisplayLogic: class {
    func displayData(viewModel: ProfileModel, keysArray: [String])
}

protocol AVPhotoSender: class {
    func sendImage(_ image: UIImage)
}

class ProfileViewController: UIViewController, ProfileDisplayLogic {
    
    @IBOutlet private var profileTableView: UITableView!
    
    private var currentRegion: String!
    private let picker = UIImagePickerController()
    var photoCellDelegate: AVPhotoSender!
    
    var interactor: ProfileBusinessLogic?
    private var keysArray: [String]!
    private var user: ProfileModel!
    var flagDelegate: SelectFlagDelegate!
    
    private func setup() {
        let viewController        = self
        let interactor            = ProfileInteractor()
        let presenter             = ProfilePresenter()
        viewController.interactor = interactor
        interactor.presenter      = presenter
        presenter.viewController  = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        profileTableView.dataSource = self
        profileTableView.delegate = self
        
        profileTableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
        profileTableView.register(UINib(nibName: "UserDataTableViewCell", bundle: nil), forCellReuseIdentifier: "UserDataTableViewCell")
        profileTableView.register(UINib(nibName: "ProfessionTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfessionTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor?.makeRequest()
    }
    
    func displayData(viewModel: ProfileModel, keysArray: [String]) {
        self.keysArray = keysArray
        user = viewModel
        profileTableView.reloadData()
    }
    
    func openCamera() {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            picker.sourceType = UIImagePickerController.SourceType.camera
            self.present(picker, animated: true, completion: nil)
        }
        else
        {
            let alertWarning = UIAlertView(title:"Warning!", message: "You do not have camera", delegate:nil, cancelButtonTitle:"OK")
            alertWarning.show()
        }
    }
    func openGallery() {
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_flag_screen" {
            let flagViewController = segue.destination as! FlagViewController
            flagViewController.selectFlagDelegate = self
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            let sectionHeader = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            
            let sectionText = UILabel()
            sectionText.frame = CGRect.init(x: 16, y: 5, width: sectionHeader.frame.width-10, height: sectionHeader.frame.height-10)
            sectionText.text = "Professional Information:"
            sectionText.font = .systemFont(ofSize: 16, weight: .bold)
            sectionText.textColor = .black
            sectionHeader.addSubview(sectionText)
            return sectionHeader
        } else {
            let sectionHeader = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 0))
            return sectionHeader
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            view.endEditing(true)
            
            let alert:UIAlertController = UIAlertController(title: "Choose Photo", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
            let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default)
            {
                UIAlertAction in
                self.openCamera()
            }
            let gallaryAction = UIAlertAction(title: "Galery", style: UIAlertAction.Style.default)
            {
                UIAlertAction in
                self.openGallery()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            {
                UIAlertAction in
            }
            
            picker.delegate = self
            alert.addAction(cameraAction)
            alert.addAction(gallaryAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 170
        case 1:
            return 160
        case 2:
            return 120
        default:
            return 160
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 11
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as? PhotoTableViewCell else {
                return UITableViewCell()
            }
            
            photoCellDelegate = cell
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserDataTableViewCell", for: indexPath) as? UserDataTableViewCell else {
                return UITableViewCell()
            }
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfessionTableViewCell", for: indexPath) as? ProfessionTableViewCell else {
                return UITableViewCell()
            }
            
            if indexPath.row == 4 {
                cell.delegate = self
                cell.phoneContainerView.isHidden = false
                cell.professionContainer.isHidden = true
                cell.setFlagButton(region: currentRegion)
                
                cell.phoneTextField.text = user.professionDetails[keysArray[indexPath.row]]
                
                return cell
            }
            
            
            cell.phoneContainerView.isHidden = true
            cell.professionContainer.isHidden = false
            
            cell.professionLabel.text = keysArray[indexPath.row]
            cell.professionTextView.text = user.professionDetails[keysArray[indexPath.row]]
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension ProfileViewController: SelectFlagDelegate {
    func didChoseFlag(region: String) {
        currentRegion = region
    }
}

extension ProfileViewController: CountryFlagDelegate {
    func didTapOnFlag() {
        performSegue(withIdentifier: "to_flag_screen", sender: self)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        photoCellDelegate.sendImage(fixOrientation(originalImage: image!)!)
    }
}
