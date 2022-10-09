//
//  NewsCell.swift
//  New News
//
//  Created by Ekrem Alkan on 9.10.2022.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var newsAuthor: UILabel!
    @IBOutlet weak var newsSource: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
