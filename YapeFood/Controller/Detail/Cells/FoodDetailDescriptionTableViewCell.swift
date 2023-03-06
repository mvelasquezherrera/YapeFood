//
//  FoodDetailDescriptionTableViewCell.swift
//  YapeFood
//
//  Created by Marcelo Stefano Velasquez Herrera on 6/03/23.
//

import UIKit

class FoodDetailDescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblDescription: UILabel!
    
    static let identifier = "FoodDetailDescriptionTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "FoodDetailDescriptionTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - SETUP VIEW
extension FoodDetailDescriptionTableViewCell {
    
    func setupCell(description: String) {
        lblDescription.text = description
        lblDescription.textColor = .black
        lblDescription.font = .systemFont(ofSize: 14)
        lblDescription.numberOfLines = 0
        lblDescription.textAlignment = .left
    }
    
}
