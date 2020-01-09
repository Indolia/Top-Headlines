//
//  iKeyChain.swift
//  Top Headlines
//
//  Created by Rishi pal on 06/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import Foundation

class IKeyChain {
    
    class func save(key: String, data: Data) -> OSStatus {
        let query = [kSecClass as String : kSecClassGenericPassword as String,
                     kSecAttrAccount as String : key,
                     kSecValueData as String   : data ] as [String : Any]
        
        SecItemDelete(query as CFDictionary)
        
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    class func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        
        var dataTypeRef: AnyObject? = nil
        
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    
    class func delete(key: String) {
        let query = [kSecClass as String : kSecClassGenericPassword as String,
                            kSecAttrAccount as String : key]
        let status = SecItemDelete(query as CFDictionary)
        print(status.description)
        
    }
}

extension Data {
    
   static func archivedData(from object: Any)-> Data? {
        do {
            return  try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
        } catch let error {
            print(error)
        }
        return nil
    }
    
    func unarchivedObject()-> Any? {
        do {
            return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(self)
        }catch let error {
           print(error)
        }
        return nil
    }
    
}

