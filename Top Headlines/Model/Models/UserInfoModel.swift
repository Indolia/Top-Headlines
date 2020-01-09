//
//  UserInfoModel.swift
//  Top Headlines
//
//  Created by Rishi pal on 07/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import Foundation

struct UserInfoModel {
    let userName: String
    let password: String
    
}

// sign in logic
extension UserInfoModel {
    func signIn(completion:(Any?)->Void) {
      let userData =  IKeyChain.load(key: AppConstants.UserInfo.key)
        if let someUserData = userData {
            let userInfo = someUserData.unarchivedObject()
            completion(userInfo)
        }else {
            completion(nil)
        }
    }
}

// sign up logic

extension UserInfoModel {
    func signUp(completion:(Bool)->Void) {
        let userInfo = self.json()
        print(userInfo)
        let userData = Data.archivedData(from: userInfo)
        if let someData = userData {
            let status = IKeyChain.save(key: AppConstants.UserInfo.key, data: someData)
            if status == noErr {
               completion(true)
            }else {
                completion(false)
            }
        }
    }
    
    func json()-> Dictionary<String,String> {
        let json = ["userName" : self.userName, "password" : self.password]
        return json
    }
    
}
