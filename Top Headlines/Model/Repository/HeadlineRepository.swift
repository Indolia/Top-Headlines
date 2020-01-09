//
//  HeadlineRepository.swift
//  Top Headlines
//
//  Created by Rishi pal on 08/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import Foundation

enum  ItemDataResponse {
    case success(result: HeadlineList)
    case failure
}

class HeadlineRepository: BaseService {
    
    func getHeadlines( completion: @escaping (ItemDataResponse) -> Void) {
        super.callEndPoint(endPoint: "") { [weak self](response) in
            guard let strongSelf = self else { return }
            switch response {
            case .success(let result):
                strongSelf.parseResult(result: result, completion: completion)
                break
            default:
                completion(.failure)
                break
            }
        }
    }
    
    private func parseResult(result: JsonDictionay,completion: @escaping (ItemDataResponse) -> Void) {
        guard let data = HeadlineList(json: result) else {
            completion(.failure)
            return
        }
        completion(.success(result: data))
    }
}


