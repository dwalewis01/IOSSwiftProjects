//
//  TheaterTableViewCell.swift
//  MovieTrailers
//
//  Created by Dwayne Lewis on 1/7/19.
//  Copyright © 2019 Dwayne Lewis. All rights reserved.
//

import UIKit

class TheaterTableViewCell: UITableViewCell {
    
    @IBOutlet var name : UILabel!
    @IBOutlet var location: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
