//
//  FoodCollectionViewCell.swift
//  YapeFood
//
//  Created by Marcelo Stefano Velasquez Herrera on 5/03/23.
//

import UIKit
import SDWebImage

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
        downloadImage(nameImg: nameImg)
        viewContentTitle.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        lblFood.text = nameFood
        lblFood.textColor = .white
        lblFood.font = .boldSystemFont(ofSize: 14)
        lblFood.numberOfLines = 0
        lblFood.textAlignment = .center
    }
    
    func downloadImage(nameImg: String) {
        SDWebImageManager.shared.loadImage(with: URL(string: nameImg), options: .continueInBackground, progress: nil) { image, data, error, cacheType, isFinished, url in
            if error == nil {
                guard let imageDownloaded = image else { return }
                self.imgFood.image = imageDownloaded
            } else {
                // Error al descargar la imagen
                self.imgFood.image = UIImage()
            }
        }
    }
    
}
