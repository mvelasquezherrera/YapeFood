//
//  HomeFoodHeaderView.swift
//  YapeFood
//
//  Created by Marcelo Stefano Velasquez Herrera on 5/03/23.
//

import UIKit

class HomeFoodHeaderView: UIView {
    
    @IBOutlet weak var lblTitle: UILabel!

    var section = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func instanceFromNib() -> HomeFoodHeaderView {
        return UINib(nibName: "HomeFoodHeaderView", bundle: nil).instantiate(withOwner: nil)[0] as! HomeFoodHeaderView
    }

}

// MARK: - SETUP VIEW
extension HomeFoodHeaderView {
    
    func setupHeader(title: String) {
        self.backgroundColor = .lightGray
        lblTitle.text = title
        lblTitle.font = .boldSystemFont(ofSize: 16)
        lblTitle.textColor = .black
        lblTitle.numberOfLines = 0
        lblTitle.textAlignment = .left
    }
    
}
