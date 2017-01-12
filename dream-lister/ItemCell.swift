//
//  ItemCell.swift
//  dream-lister
//
//  Created by Yuen Hsi Chang on 1/11/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    

    func updateUI(item: Item) {
        titleLabel.text = item.title
        priceLabel.text = "$\(item.price)"
        detailLabel.text = item.details
        if let img = item.toImage?.image as? UIImage {
            thumbImg.image = img
        }
    }
}
