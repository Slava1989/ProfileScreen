//
//  ProfileInteractor.swift
//  ProfileScreen
//
//  Created by Veaceslav Chirita on 5/13/20.
//  Copyright (c) 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit

protocol ProfileBusinessLogic {
    func makeRequest()
}

class ProfileInteractor: ProfileBusinessLogic {
    
    var presenter: ProfilePresentationLogic?
    
    func makeRequest() {
        presenter?.presentData(response: getProfile(), keysArray: getKeys())
    }
    
    func getProfile() -> ProfileModel {
        return ProfileModel(
            name: "Brandon McCourtney",
            userName: "brandon_mc",
            email: "brandon_mc@gmail.com",
            professionDetails: [
                "Profession": "PersonalTrainer",
                "Industry": "Beauty",
                "Skills": "Ninja Warrior, BodyWeight Fitness, Dietary Advice, Boxing",
                "Profession details": "I teach classes in HealthCity on Mondays and Wednesdays",
                "Phone": "+31 (256) 212-34-34",
                "Location of Services": "Amsterdam, NL",
                "Instagram": "@brandonmc",
                "Facebook": "facebook.com/brandon.mc",
                "Website": "brandonfitness.nl",
                "Company": "HealthCity Amsterdam",
                "Address": "Prins Hendikkade 47"
            ]
        )
    }
    
    func getKeys() -> [String] {
        return [
            "Profession",
            "Industry",
            "Skills",
            "Profession details",
            "Phone",
            "Location of Services",
            "Instagram",
            "Facebook",
            "Website",
            "Company",
            "Address"
        ]
    }
}
