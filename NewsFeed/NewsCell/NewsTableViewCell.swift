//
//  NewsTableViewCell.swift
//  NewsFeed
//
//  Created by Denis Kalashnikov on 2/26/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsContentLabel: UILabel!
    @IBOutlet weak var newsRemarkLabel: UILabel!
    
    
    
    static let id = "NewsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(model: Article) {
        if let imageURL = model.urlToImage {
            let url = URL(string: imageURL)
            newsImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "image-placeholder"))
        }
        newsTitleLabel.text = model.title
        newsContentLabel.text = model.content
        newsRemarkLabel.text = "\(model.author ?? "") · \(dateFormat(model.publishedAt))"
    }
    
    func dateFormat(_ date: Date?) -> String {
        guard let date = date else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: date)
    }
    
}
