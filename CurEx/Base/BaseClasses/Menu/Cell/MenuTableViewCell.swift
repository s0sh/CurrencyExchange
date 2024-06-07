//
//  MenuTableViewCell.swift
//  ExpenceHit
//
//  Created by Roman Bigun on 05.06.2024.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setLabel(categoryName: String) {
        nameLabel.text = categoryName
    }
    
}
