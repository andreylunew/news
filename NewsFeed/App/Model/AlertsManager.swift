//
//  AlertsManager.swift
//  NewsFeed
//
//  Created by Admin on 05.02.2023.
//

import UIKit

class AlertsManager {
	
	private init() {}
	static let shared = AlertsManager()
	
	func showWarning(title: String, message: String? = nil) {
		let ac = UIAlertController(title: title, message: message ?? "", preferredStyle: .alert)
		let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
		ac.addAction(ok)
        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(ac, animated: true, completion: nil)
        }
		
	}
}

extension UIApplication {
	static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
		if let navigationController = base as? UINavigationController {
			return topViewController(base: navigationController.visibleViewController)
		}
		if let presented = base?.presentedViewController {
			return topViewController(base: presented)
		}
		return base
	}
}
