//
//  FoodDetailViewController.swift
//  YapeFood
//
//  Created by Marcelo Stefano Velasquez Herrera on 6/03/23.
//

import UIKit
import SDWebImage

class FoodDetailViewController: BaseViewController {

    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var viewContentTitle: UIView!
    @IBOutlet weak var lblFood: UILabel!
    @IBOutlet weak var tableInfo: UITableView!
    
    var food: Foods?
    
    var listTitleSections = ["Descripción", "Ingredientes", "Preparación", "Origen", "Ubicación"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }

}

// MARK: - SETUP VIEW
extension FoodDetailViewController {
    
    func setupView() {
        setupNavigationController()
        setupHeader()
        setupTable()
    }
    
    func setupNavigationController() {
        self.title = food?.name ?? ""
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupHeader() {
        if let nameImg = food?.image {
            downloadImage(nameImg: nameImg)
        }
        imgFood.contentMode = .scaleAspectFill
    }
    
    func setupTable() {
        tableInfo.delegate = self
        tableInfo.dataSource = self
        tableInfo.register(FoodDetailDescriptionTableViewCell.nib(), forCellReuseIdentifier: FoodDetailDescriptionTableViewCell.identifier)
        tableInfo.register(FoodDetailMapTableViewCell.nib(), forCellReuseIdentifier: FoodDetailMapTableViewCell.identifier)
        tableInfo.estimatedRowHeight = UITableView.automaticDimension
        tableInfo.showsHorizontalScrollIndicator = false
        tableInfo.showsVerticalScrollIndicator = false
        tableInfo.separatorStyle = .none
        if #available(iOS 15.0, *) {
            tableInfo.sectionHeaderTopPadding = 0.0
        }

        tableInfo.reloadData()
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
    
    func createHeader(section: Int, title: String) -> UIView {
        let header = HomeFoodHeaderView.instanceFromNib()
        header.section = section
        header.setupHeader(title: title)
        return header
    }
    
    func getNumberOfSections() -> Int {
        return listTitleSections.count
    }
    
    func getNumberOfRowsPerSections() -> Int {
        return 1
    }
    
    func createCellDescription(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodDetailDescriptionTableViewCell.identifier, for: indexPath) as! FoodDetailDescriptionTableViewCell
        cell.setupCell(description: food?.description ?? "")
        return cell
    }
    
    func createCellIngredients(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodDetailDescriptionTableViewCell.identifier, for: indexPath) as! FoodDetailDescriptionTableViewCell
        var concatIngredients = ""
        if let ingredients = food?.ingredients {
            for ingredient in ingredients {
                concatIngredients += "\(ingredient.nameIngredient)\n"
            }
        }
        
        cell.setupCell(description: concatIngredients)
        
        return cell
    }
    
    func createCellPreparation(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodDetailDescriptionTableViewCell.identifier, for: indexPath) as! FoodDetailDescriptionTableViewCell
        cell.setupCell(description: food?.preparation ?? "")
        return cell
    }
    
    func createCellOrigin(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodDetailDescriptionTableViewCell.identifier, for: indexPath) as! FoodDetailDescriptionTableViewCell
        cell.setupCell(description: food?.origin ?? "")
        return cell
    }
    
    func createCellLocation(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodDetailMapTableViewCell.identifier, for: indexPath) as! FoodDetailMapTableViewCell
        cell.setAnnotation(origin: food?.origin ?? "", latitude: food?.latitude ?? "", longitude: food?.longitude ?? "")
        return cell
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FoodDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        createHeader(section: section, title: listTitleSections[section])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getNumberOfRowsPerSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return createCellDescription(tableView: tableView, indexPath: indexPath)
        case 1:
            return createCellIngredients(tableView: tableView, indexPath: indexPath)
        case 2:
            return createCellPreparation(tableView: tableView, indexPath: indexPath)
        case 3:
            return createCellOrigin(tableView: tableView, indexPath: indexPath)
        case 4:
            return createCellLocation(tableView: tableView, indexPath: indexPath)
        default:
            return UITableViewCell()
        }
//        createCell(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
