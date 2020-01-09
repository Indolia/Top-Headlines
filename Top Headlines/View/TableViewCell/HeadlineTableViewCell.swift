//
//  HeadlineTableViewCell.swift
//  Top Headlines
//
//  Created by Rishi pal on 08/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import UIKit

class HeadlineTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var headlineImage: UIImageView!
    @IBOutlet var publishDateLabel: UILabel!
    @IBOutlet var innerContentView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        innerContentView.cornerRadius(with: 8)
        innerContentView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        innerContentView.layer.borderWidth = 0.75
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(for model: HeadlineModel) {
        titleLabel.text = model.title
        publishDateLabel.text = publishDateLabelText(from: model)
        guard let someUrl = model.urlToImage else{
            headlineImage.image = nil
            return
        }
        headlineImage.setImage(for: someUrl , placeholder: nil) { (image) in}
    }
    
    func publishDateLabelText(from model: HeadlineModel) -> String {
        var text  = ""
        if let someAuthor = model.author {
            text = someAuthor
        }
        text = text + " \(model.publishedAt.toString)"
        return text
    }
    
}
