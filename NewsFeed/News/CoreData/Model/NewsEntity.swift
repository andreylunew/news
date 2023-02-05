//
//  NewsEntity.swift
//  NewsFeed
//
//  Created by Admin on 05.02.2023.
//

import Foundation
import CoreData
import UIKit

extension NewsEntity {
	static func createNew(from dictionary: [String: AnyObject]) -> NewsEntity? {
        guard 	let sourceValue = dictionary["source"] as? [String: AnyObject],
            let source = sourceValue["name"] as? String,
			let title = dictionary["title"] as? String,
            let descript = dictionary["description"] as? String,
			let urlSlug = dictionary["url"] as? String,
            let urlImg = dictionary["urlToImage"] as? String,
			let date = dictionary["publishedAt"] as? String
			//let text = dictionary["text"] as? String
			else { return nil }
        
		guard CoreDataStack.shared.fetch(NewsEntity.self, title: title) == nil else { return nil }
		
		let context = CoreDataStack.shared.getContext()
		guard let newsEntity = NSEntityDescription.insertNewObject(forEntityName: "NewsEntity", into: context) as? NewsEntity else { return nil }
        newsEntity.source = source
		newsEntity.title = title
        newsEntity.descript = descript
		newsEntity.urlSlug = urlSlug
        newsEntity.urlImg = urlImg
		newsEntity.date = date
        
        NetworkManager.shared.saveImage(urlImg: urlImg) { image in
            guard let image = image else {
                print("Failed to download image")
                return
            }
            newsEntity.image = image.jpegData(compressionQuality: 1.0)
        }
        return newsEntity
		
	}
    
}
