//
//  Headline+CoreDataProperties.swift
//  Top Headlines
//
//  Created by Rishi pal on 09/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//
//

import Foundation
import CoreData


extension Headline {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Headline> {
        return NSFetchRequest<Headline>(entityName: "Headline")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var author: String?
    @NSManaged public var title: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var url: String?
    @NSManaged public var publishedAt: Date?
    @NSManaged public var content: String?
    @NSManaged public var urlToImage: String?
    
    var deadlineModel: HeadlineModel {
        get {
            let source = HeadlineModel.Source(id: id, name: name!)
            return HeadlineModel(source: source, author: author, title: title, description: descriptions, url: url, urlToImage: urlToImage, publishedAt: publishedAt!, content: content)
        }
    }
    
    static func instance(from model: HeadlineModel, entityName: String, context: NSManagedObjectContext)-> Headline {
        let entity = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! Headline
        entity.id = model.source.id
        entity.name = model.source.name
        entity.author = model.author
        entity.title = model.title
        entity.descriptions = model.description
        entity.url = model.url
        entity.publishedAt = model.publishedAt
        entity.content = model.content
        entity.urlToImage = model.urlToImage
        return entity
    }
}

extension Headline {
   static func getListOfEntity(with models:[HeadlineModel])->[Headline] {
        var list = [Headline]()
       let viewContext = CoreDataManager.share.viewContext()
        for model in models {
            list.append(Headline.instance(from: model, entityName: "Headline", context: viewContext))
        }
        return list
    }
    
    static func getHeadlineModelList(with entitties:[Headline])->[HeadlineModel] {
        var list = [HeadlineModel]()
        
        for entity in entitties {
            list.append(entity.deadlineModel)
        }
        return list
    }
    
    static func saveHeadlineInLocal(with models:[HeadlineModel]) {
        let entities = getListOfEntity(with: models)
        if entities.count > 0 {
           CoreDataManager.share.saveContext()
        }
    }
}
