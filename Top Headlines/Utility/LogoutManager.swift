//
//  LogoutManager.swift
//  Top Headlines
//
//  Created by Rishi pal on 09/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import Foundation
import CoreData
struct LogoutManager {
    static func logout() {
        IKeyChain.delete(key: AppConstants.UserInfo.key)
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Headline")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        CoreDataManager.share.deleteAll(for: batchDeleteRequest)
    }
}
