//
//  HeadlineDetailsTableViewCell.swift
//  Top Headlines
//
//  Created by Rishi pal on 09/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import UIKit

class HeadlineDetailsTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var headlineImage: UIImageView!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var publishedAtLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var contentTextView: UITextView!
    @IBOutlet var urlTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        urlTextView.tintColor = UIColor.skyBlue
        contentTextView.tintColor = UIColor.skyBlue
        // Configure the view for the selected state
    }
    
    
    func configure(model: HeadlineModel) {
        titleLabel.text = model.title
        headlineImage.setImage(for: model.urlToImage, placeholder: nil) { (image) in}
        descriptionLabel.text = model.description
        authorLabel.text = model.author
        publishedAtLabel.text = model.publishedAt.toString
        urlTextView.text = model.url
        contentTextView.text = model.content
    }
     
}
