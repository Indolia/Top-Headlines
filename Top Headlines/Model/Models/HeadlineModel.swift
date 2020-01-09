//
//  HeadlineModel.swift
//  Top Headlines
//
//  Created by Rishi pal on 07/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import Foundation

struct HeadlineModel : JsonSerializable {
    
    struct Source {
        let id: String?
        let name: String
        
        init(id: String?, name: String) {
            self.id = id
            self.name = name
        }
        
        init?(json: JsonDictionay) {
            guard let name = json["name"] as? String else {
                return nil
            }
            let id = json["id"] as? String
            self.init(id: id, name: name)
        }
    }
    
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date
    let content: String?
    
    init(source: Source, author: String?, title: String?, description: String?,url: String? , urlToImage: String?, publishedAt: Date, content: String?  ) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    
    init?(json: JsonDictionay) {
        guard let sourceRowData = json["source"] as? JsonDictionay, let source = Source.init(json: sourceRowData) else {
            return nil
        }
        
        guard let publishedAtStr = json["publishedAt"] as? String, let publishedAt = Date.getDate(fromString: publishedAtStr) else {
            return nil
        }
        let author = json["author"] as? String
        let title = json["title"] as? String
        let description = json["description"] as? String
        let url = json["url"] as? String
        let urlToImage = json["urlToImage"] as? String
        let content = json["content"] as? String
        self.init(source: source, author: author, title: title, description: description,url: url , urlToImage: urlToImage, publishedAt: publishedAt, content: content  )

    }
    
}

