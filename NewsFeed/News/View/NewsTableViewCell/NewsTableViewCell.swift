//
//  NewsTableViewCell.swift
//  NewsFeed
//
//  Created by Admin on 05.02.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

	@IBOutlet weak var countLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!
	
	static let cellIdentifier = "titleCell"
	
	func configure(with news: NewsEntity) {
		titleLabel.text = news.title
        let counterText = String(news.viewsCounter)
		countLabel.text = counterText
		countLabel.layer.cornerRadius = countLabel.bounds.height / 2
		countLabel.layer.masksToBounds = true
	}
    
}
