//
//  mainTableViewCell.swift
//  ABODOios
//
//  Created by Kawika Avilla on 4/12/16.
//  Copyright © 2016 kawikaavilla. All rights reserved.
//

import UIKit

class mainTableViewCell: UITableViewCell {

    @IBOutlet weak var propertyImageView: UIImageView!
    @IBOutlet weak var bedsRangeLabel: UILabel!
    @IBOutlet weak var propertyNameLabel: UILabel!
    @IBOutlet weak var priceRangeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
