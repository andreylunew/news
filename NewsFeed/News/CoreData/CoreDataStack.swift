//
//  CoreDataStack.swift
//  NewsFeed
//
//  Created by Admin on 05.02.2023.
//

import Foundation
import CoreData

class CoreDataStack {
	private init() {}
	static let shared = CoreDataStack()
	
	lazy var persistentContainer: NSPersistentContainer = {
		
		let container = NSPersistentContainer(name: "NewsFeed")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	
	func getContext() -> NSManagedObjectContext {
		return persistentContainer.viewContext
	}
	
	func saveContext () {
		let context = getContext()
		if context.hasChanges {
			do {
				try context.save()
				print("saved")
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
	
	func fetch<T: NSManagedObject>(_ objectType: T.Type, title: String) -> T? {
		let entityName = String(describing: objectType)
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
		fetchRequest.predicate = NSPredicate(format: "title = %@", title)
		do {
			if let result = try CoreDataStack.shared.getContext().fetch(fetchRequest).first as? T {
				return result
			}
		} catch {
			print("Error in \(#function) at line \(#line): \(entityName) with title=\(title) not found")
			return nil
		}
		return nil
	}
    
	
	func fetchAll<T: NSManagedObject>(_ objectType: T.Type) -> [T]? {
		let entityName = String(describing: objectType)
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
		do {
			if let result = try getContext().fetch(fetchRequest) as? [T] {
				return result
			}
		} catch let error as NSError {
			print("Error in \(#function) at line \(#line): cant fetch any data for \(entityName)")
			AlertsManager.shared.showWarning(title: error.localizedDescription)
			return nil
		}
		return nil
	}
	
}
