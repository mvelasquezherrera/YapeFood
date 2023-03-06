//
//  HomeTableViewCell.swift
//  YapeFood
//
//  Created by Marcelo Stefano Velasquez Herrera on 4/03/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionFoods: UICollectionView!
    
    static let identifier = "HomeTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "HomeTableViewCell", bundle: nil)
    }
    
    var parentVC = UIViewController()

    var foods = [Foods]() {
        didSet {
            collectionFoods.reloadData()
        }
    }
    var section = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - SETUP VIEW
extension HomeTableViewCell {
    
    func setupCollection() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionFoods.collectionViewLayout = flowLayout
        collectionFoods.register(FoodCollectionViewCell.nib(), forCellWithReuseIdentifier: FoodCollectionViewCell.identifier)
        collectionFoods.dataSource = self
        collectionFoods.delegate = self
        collectionFoods.isPagingEnabled = false
        collectionFoods.showsVerticalScrollIndicator = false
        collectionFoods.showsHorizontalScrollIndicator = false
        collectionFoods.backgroundColor = .clear
        collectionFoods.reloadData()
    }
    
    func getNumberOfItemsInSection() -> Int {
        return foods.count
    }
    
    func getDataFoods(row: Int) -> Foods {
        return foods[row]
    }
    
    func createCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCollectionViewCell.identifier, for: indexPath) as! FoodCollectionViewCell
        cell.setupCell(nameImg: getDataFoods(row: indexPath.row).image, nameFood: getDataFoods(row: indexPath.row).name)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        getNumberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        createCell(collectionView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FoodDetailViewController") as? FoodDetailViewController else { return }
        vc.food = foods[indexPath.row]
        parentVC.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
