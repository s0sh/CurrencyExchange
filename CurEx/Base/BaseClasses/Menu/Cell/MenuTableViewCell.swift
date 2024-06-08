//
//  MenuTableViewCell.swift
//  ExpenceHit
//
//  Created by Roman Bigun on 05.06.2024.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var flagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setLabel(categoryName: String) {
        nameLabel.text = categoryName
        if categoryName != "none" {
            flagLabel.text = countryFlag(countryCode: categoryName)
        } else {
            flagLabel.isHidden = true
        }
    }
}

func countryFlag(countryCode: String) -> String {
    return String(String.UnicodeScalarView(
       countryCode.unicodeScalars.compactMap(
         { UnicodeScalar(127397 + $0.value) })))
}
