//
//  HeallinesViewModel.swift
//  Top Headlines
//
//  Created by Rishi pal on 07/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import Foundation
import CoreData

protocol HeadlinesViewModelDelegate: class {
    func reloadTable()
}

class HeadlinesViewModel {
    
    var dataItems:[HeadlineModel] = []
    var repository: HeadlineRepository?
    weak var delegate: HeadlinesViewModelDelegate?
    
    init() {
        repository = HeadlineRepository()
    }
    
    func getHeadlines() {
        guard let repo = repository else { return }
        repo.getHeadlines {  [weak self](response) in
            guard let strongSelf = self else { return }
            switch response {
            case .success(let result):
                strongSelf.dataItems = result.results
                strongSelf.saveHeadlinesInLocal()
                strongSelf.delegate?.reloadTable()
            case.failure:
                break
            }
        }
    }
}


// Local storage logic
extension HeadlinesViewModel {
    
   private func saveHeadlinesInLocal() {
        cleanAllHeadlineFromLocal()
        Headline.saveHeadlineInLocal(with: dataItems)
    }
    
    private func cleanAllHeadlineFromLocal() {
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Headline")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        CoreDataManager.share.deleteAll(for: batchDeleteRequest)
    }

   func fetchLocalHeadline() {
        let fetchRequest:NSFetchRequest<Headline> = Headline.fetchRequest()
        let managedContext = CoreDataManager.share.viewContext()
        do {
            let headlines = try managedContext.fetch(fetchRequest)
            let items = headlines.map{$0.deadlineModel}
            dataItems = items
            delegate?.reloadTable()
    
        }catch let error as NSError {
           print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    
}

