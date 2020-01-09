//
//  HeadlineList.swift
//  Top Headlines
//
//  Created by Rishi pal on 08/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import Foundation


struct HeadlineList {
    
    let status    : String
    let totalResults  : Int
    var results        : [HeadlineModel]
    
    /**
     Receive parameters for initializer the struct from api
     - Parameter status
     - Parameter totalResults
     - Parameter results
     */
    init(status:String,totalResults:Int,results:[HeadlineModel]){
        self.status    = status
        self.totalResults  = totalResults
        self.results        = results
    }

    /**
     This init receive and validate data from Json, return nil in case the struct not is available, if all data is true  call super init fof the struct
     - Parameter json : Data from Api Rest
     */
    init?(json: JsonDictionay) {
        guard let status     = json["status"] as? String else { return nil }
        guard let totalResults   = json["totalResults"] as? Int else { return nil }
        guard let results         = HeadlineModel.createRequiredInstances(from: json , key: "articles") else { return nil }
        self.init(status:status,totalResults:totalResults,results:results)
    }
}
