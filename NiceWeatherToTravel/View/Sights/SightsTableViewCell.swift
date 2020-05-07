//
//  SightsTableViewCell.swift
//  NiceWeatherToTravel
//
//  Created by user166683 on 5/2/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import UIKit

class SightsTableViewCell: UITableViewCell {

    @IBOutlet weak var sightImageView: UIImageView!
    @IBOutlet weak var sightNameLabel: UILabel!
    @IBOutlet weak var sightDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
