//
//  NewsTableViewCell.swift
//  Newster
//
//  Created by Dwayne Lewis on 12/22/18.
//  Copyright © 2018 Dwayne Lewis. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title : UILabel?
    @IBOutlet weak var newImage : UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
