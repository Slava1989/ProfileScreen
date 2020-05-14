//
//  ProfilePresenter.swift
//  ProfileScreen
//
//  Created by Veaceslav Chirita on 5/13/20.
//  Copyright (c) 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit

protocol ProfilePresentationLogic {
    func presentData(response: ProfileModel, keysArray: [String])
}

class ProfilePresenter: ProfilePresentationLogic {
  weak var viewController: ProfileDisplayLogic?
  
  func presentData(response: ProfileModel, keysArray: [String]) {
    viewController?.displayData(viewModel: response, keysArray: keysArray)
  }
  
}
