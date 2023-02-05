//
//  AppDelegate.swift
//  NewsFeed
//
//  Created by Admin on 05.02.2023.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		return true
	}

	func applicationWillTerminate(_ application: UIApplication) {

		CoreDataStack.shared.saveContext()
	}

}

