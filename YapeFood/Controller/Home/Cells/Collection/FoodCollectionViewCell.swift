//
//  FoodCollectionViewCell.swift
//  YapeFood
//
//  Created by Marcelo Stefano Velasquez Herrera on 5/03/23.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var viewContentTitle: UIView!
    @IBOutlet weak var lblFood: UILabel!
    
    static let identifier = "FoodCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "FoodCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

// MARK: - SETUP VIEW
extension FoodCollectionViewCell {
    
    func setupCell(nameImg: String, nameFood: String) {
        viewContent.backgroundColor = .white
        imgFood.contentMode = .scaleAspectFill
        if !nameImg.isEmpty {
            WebImageManager.downloadImage(nameImg: nameImg) { imageDownloaded in
                self.imgFood.image = imageDownloaded
            }
        }
        viewContentTitle.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        lblFood.text = nameFood
        lblFood.textColor = .white
        lblFood.font = .boldSystemFont(ofSize: 14)
        lblFood.numberOfLines = 0
        lblFood.textAlignment = .center
    }
    
}
