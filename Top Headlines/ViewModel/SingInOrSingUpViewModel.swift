//
//  SinginAndSingupViewModel.swift
//  Top Headlines
//
//  Created by Rishi pal on 07/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import Foundation

protocol SignInOrSignUPViewModelDelegate: class {
    func userSignInOrSignUp(with status: SignInOrSignUPViewModel.SignInOrSignUPStatus, message: String)
}

struct SignInOrSignUPViewModel {
    enum SignInOrSignUPStatus {
        case success
        case fail
    }
    weak var delegate: SignInOrSignUPViewModelDelegate?
    var userInfo: UserInfoModel?
    enum SignInOrSignUpError: Error {
        case userNameShouldNotBeEmpty
        case userNameLenghtAtleastThreeCharacters
        case passwordShouldNotBeEmpty
        case passwordLenghtAtleastThreeCharacters
    }
    
    func validate(userName: String?, and password: String?, completion:(Bool, UserInfoModel )->Void) throws {
        guard let someUserName = userName else {
            throw SignInOrSignUpError.userNameShouldNotBeEmpty
        }
        if someUserName.count < 3 {
            throw SignInOrSignUpError.userNameLenghtAtleastThreeCharacters
        }
        
        guard let somePassword = password else{
            throw SignInOrSignUpError.passwordShouldNotBeEmpty
        }
        if somePassword.count < 3 {
            throw SignInOrSignUpError.passwordLenghtAtleastThreeCharacters
        }
        let model = UserInfoModel(userName: someUserName, password: someUserName)
        completion(true , model)
    }
    
    mutating func setUserInfo(with model: UserInfoModel) {
        userInfo = model
    }
     
    func signIn() {
        userInfo?.signIn(completion: { (data) in
            if let someData = data, let dic = someData as? [String : String] {
                let tuple = validateSignIn(data: dic)
                let status = tuple.0  ? SignInOrSignUPStatus.success : SignInOrSignUPStatus.fail
                delegate?.userSignInOrSignUp(with: status, message: tuple.1)
            }else {
                delegate?.userSignInOrSignUp(with: .fail, message: "User name and/or password not match")
            }
        })
    }
  
    private func validateSignIn(data: [String : String])-> (Bool, String) {
        if userInfo?.userName == data["userName"], userInfo?.password == data["password"] {
            return (true, "User Sign in successfully.")
        }else {
            return (false, "User name and/or password not match.")
        }
    }
    
    func signUp() {
        userInfo?.signUp(completion: { (status) in
            let someStatus = status ? SignInOrSignUPStatus.success : SignInOrSignUPStatus.fail
            let message = status ? "User Sign Up successfully." : "User Sign Up fail"
            delegate?.userSignInOrSignUp(with: someStatus, message: message)
        }
        )
    }
}

extension SignInOrSignUPViewModel.SignInOrSignUpError : LocalizedError {
    var localizedDescription: String {
        get {
            switch self {
            case .userNameShouldNotBeEmpty:
                return "Please enter a valid username."
            case.userNameLenghtAtleastThreeCharacters:
                return "Username have atleast 3 characters."
            case .passwordShouldNotBeEmpty:
                return "Please enter a valid password."
            case .passwordLenghtAtleastThreeCharacters:
                return "Password have alleast 3 characters"
            }
        }
    }
}

