//
//  WelcomeViewController.swift
//  Top Headlines
//
//  Created by Rishi pal on 07/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signupButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
        // Do any additional setup after loading the view.
    }

    
    func uiSetup() {
        signInButton.applyGradient(colours: UIColor.gradientColors, locations: [0.5 , 1.0])
        signInButton.cornerRadius(with: 8)
        signupButton.applyGradient(colours: UIColor.gradientColors, locations: [0.5 , 1.0])
        signupButton.cornerRadius(with: 8)
    }
    

    @IBAction func signInButtonTapped(_ sender: Any) {
        let signInVC  =  SignInOrSignUpViewController.get(with: .signIn)
        guard let someSignUPVC = signInVC else {
            fatalError("SignInViewController not find")
        }
        navigationController?.pushViewController(someSignUPVC, animated: true)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let signUpVC = SignInOrSignUpViewController.get(with: .signUp)
        guard let someSignUpVC = signUpVC else {
             fatalError("SignUpViewController not find")
        }
        navigationController?.pushViewController(someSignUpVC, animated: true)
    }
    

}
