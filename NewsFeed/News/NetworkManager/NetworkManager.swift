//
//  NetworkManager.swift
//  NewsFeed
//
//  Created by Admin on 05.02.2023.
//

import Foundation
import UIKit


	struct PaginationSettings {
		private init() {}
		static let shared = PaginationSettings()
		private(set) var pageSize = 20
		mutating func setPageSize(to size: Int) {
			if size > 0 {
				pageSize = size
			} else {
				pageSize = 0
			}
		}
	}


enum Result<T> {
	case succes(T)
	case error(String)
}

class NetworkManager {
	
	private init() {}
	static let shared = NetworkManager()
	
	func getNewslist(page: Int, completion: @escaping(Result<[[String: AnyObject]]>) -> ()) {
		let pageSettings = PaginationSettings.shared
		guard let url = URL(string: "https://newsapi.org/v2/top-headlines?category=entertainment&language=en&apiKey=2866c863cf184b47903db110145d7bfe&pageSize=\(pageSettings.pageSize)") else { return }
        //https://newsapi.org/v2/top-headlines?category=entertainment&language=en&apiKey=2866c863cf184b47903db110145d7bfe&pageSize=
        //https://newsapi.org/v2/everything?q=bitcoin&apiKey=2866c863cf184b47903db110145d7bfe&pageSize=
		let session = URLSession.shared
		let task = session.dataTask(with: url) {(data, _, error) in
			guard error == nil else {
				print("Error in \(#function) at line \(#line):\(error!.localizedDescription) ")
				return completion(.error(error!.localizedDescription))
			}
			guard let data = data else {
				return completion(.error("No data received"))
			}
			
			do {
				let json = try JSONSerialization.jsonObject(with: data, options: [])
				guard let response = json as? [String: AnyObject] else {
					return completion(.error(error?.localizedDescription ?? "No data retrieve"))
				}
				guard let incomingArray = response["articles"] as? [[String: AnyObject]] else {
					return completion(.error(error?.localizedDescription ?? "No valid data retrieve"))
				}
				DispatchQueue.main.async {
					completion(.succes(incomingArray))
				}
			} catch let error {
				print("Error in \(#function) at line \(#line): \(error.localizedDescription)")
				completion(.error(error.localizedDescription))
			}
		}
		task.resume()
	}

    func saveImage(urlImg: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlImg) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
        task.resume()
    }
    
	
	func getNewsContent(urlSlug: String, completion: @escaping (Result<String>) -> ()) {
        DispatchQueue.main.async {
            completion(.succes(urlSlug))
        }
		/*guard let url = URL(string: "\(urlSlug)") else { return }
		let session = URLSession.shared
		let task = session.dataTask(with: url) {(data, _, error) in
			guard error == nil else {
				print("Error in \(#function) at line \(#line):\(error!.localizedDescription) ")
				return completion(.error(error!.localizedDescription))
			}
			guard let data = data else {
				return completion(.error("No data received"))
			}
			
			do {
				let json = try JSONSerialization.jsonObject(with: data, options: [])
				guard let response = json as? [String: AnyObject] else {
					return completion(.error(error?.localizedDescription ?? "No data retrieve"))
				}
				guard let incomingDict = response["response"] as? [String: AnyObject] else {
					return completion(.error(error?.localizedDescription ?? "No data retrieve"))
				}
				guard let content = incomingDict["text"] as? String else {
					return completion(.error(error?.localizedDescription ?? "No valid data retrieve"))
				}
				DispatchQueue.main.async {
					completion(.succes(content))
				}
			} catch let error {
				print("Error in \(#function) at line \(#line): \(error.localizedDescription)")
				completion(.error(error.localizedDescription))
			}
		}
		task.resume()*/
	}
	
	
	
}
