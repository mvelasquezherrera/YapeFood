//
//  HomeViewController.swift
//  YapeFood
//
//  Created by Marcelo Stefano Velasquez Herrera on 4/03/23.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tableFoods: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let interactor = FoodInteractor(foodRepository: FoodRepository())
    
    var listFoods = [FoodCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListFoods()
        setupView()
    }
    
}

// MARK: - SETUP VIEW
extension HomeViewController {
    
    func setupView() {
        setupNavigationController()
        setupTable()
    }
    
    func setupNavigationController() {
        self.title = "Comidas"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupTable() {
        tableFoods.delegate = self
        tableFoods.dataSource = self
        tableFoods.register(HomeTableViewCell.nib(), forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableFoods.rowHeight = 100
        tableFoods.estimatedRowHeight = 100
        tableFoods.showsHorizontalScrollIndicator = false
        tableFoods.showsVerticalScrollIndicator = false
        tableFoods.separatorStyle = .none
        if #available(iOS 15.0, *) {
            tableFoods.sectionHeaderTopPadding = 0.0
        }

        tableFoods.reloadData()
    }
    
}

// MARK: - SETUP DATA
extension HomeViewController {
    
    func showSpinner() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    func getListFoods() {
        self.showSpinner()
        interactor.getListFoods { listFoods in
            self.hideSpinner()
            self.listFoods = listFoods
            DispatchQueue.main.async {
                self.tableFoods.reloadData()
            }
        } completionError: {
            self.hideSpinner()
            let alert = UIAlertController(title: "Error", message: "Error al cargar el listado de comidas", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Reintentar", style: .default, handler: { action in
                self.getListFoods()
            }))
            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
            self.navigationController?.pushViewController(alert, animated: true)
            print("Error listFoods")
        }

    }
    
    func createHeader(section: Int, title: String) -> UIView {
        let header = HomeFoodHeaderView.instanceFromNib()
        header.section = section
        header.setupHeader(title: title)
        return header
    }
    
    func getNumberOfSections() -> Int {
        return listFoods.count
    }
    
    func getNumberOfRowsPerSections() -> Int {
        return 1
    }
    
    func createCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        cell.selectionStyle = .none
        cell.section = indexPath.section
        cell.foods = listFoods[indexPath.section].foods
        return cell
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        createHeader(section: section, title: listFoods[section].type)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getNumberOfRowsPerSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        createCell(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
