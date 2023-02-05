//
//  NewsEntity+CoreDataProperties.swift
//  NewsFeed
//
//  Created by Admin on 05.02.2023.
//

import Foundation
import CoreData


extension NewsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsEntity> {
        return NSFetchRequest<NewsEntity>(entityName: "NewsEntity")
    }

    @NSManaged public var source: String?
    @NSManaged public var date: String?
    @NSManaged public var title: String?
    @NSManaged public var descript: String?
    @NSManaged public var text: NSDate?
    @NSManaged public var urlSlug: String?
    @NSManaged public var urlImg: String?
    @NSManaged public var viewsCounter: Int16

}
