//
//  HomeFoodTableViewCell.swift
//  YapeFood
//
//  Created by Marcelo Stefano Velasquez Herrera on 6/03/23.
//

import UIKit

class HomeFoodTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lblFood: UILabel!

    static let identifier = "HomeFoodTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "HomeFoodTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - SETUP VIEW
extension HomeFoodTableViewCell {
    
    func setupCell(nameImg: String, nameFood: String) {
        viewContent.backgroundColor = .white
        imgFood.contentMode = .scaleAspectFill
        if !nameImg.isEmpty {
            WebImageManager.downloadImage(nameImg: nameImg) { imageDownloaded in
                self.imgFood.image = imageDownloaded
            }
        }
        lblFood.text = nameFood
        lblFood.textColor = .black
        lblFood.font = .boldSystemFont(ofSize: 14)
        lblFood.numberOfLines = 0
        lblFood.textAlignment = .center
    }
    
}
