//
//  NewTableViewCell.swift
//  NewsApp
//
//  Created by Sevda Gul Baran on 1.05.2022.
//

import UIKit
import Kingfisher

class NewTableViewCell: UITableViewCell {

    @IBOutlet weak var newTitleLabel: UILabel!
    @IBOutlet weak var newDescriptionLabel: UILabel!
    @IBOutlet weak var newImageView: UIImageView!
    
    var article: Article? {
        didSet {
            newTitleLabel.text = article?.title
            newDescriptionLabel.text = article?.description
            let url = URL(string: article?.urlToImage ?? "")
            newImageView.kf.setImage(with: url, placeholder: nil, options: nil, completionHandler: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
