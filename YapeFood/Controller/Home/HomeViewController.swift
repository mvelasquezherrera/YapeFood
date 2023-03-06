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
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let interactor = FoodInteractor(foodRepository: FoodRepository())
    
    var refreshControl: UIRefreshControl?
    
    var listFoods = [FoodCategory]()
    var listFoodsOneSection = [Foods]()
    var filterListFoods = [Foods]()
    
    var searching = false
    
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
        setupSearchController()
        setupRefreshControl()
        setupTable()
    }
    
    func setupNavigationController() {
        self.title = "Comidas"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupSearchController() {
        searchController.loadViewIfNeeded()
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.backgroundColor = .white
        } else {
            // Fallback on earlier versions
        }
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Busque una comida"
        searchController.hidesNavigationBarDuringPresentation = false
        view.endEditing(true)
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .black
        refreshControl?.addTarget(self, action: #selector(refreshFoods), for: .valueChanged)
        tableFoods.refreshControl = refreshControl
    }
    
    func setupTable() {
        tableFoods.delegate = self
        tableFoods.dataSource = self
        tableFoods.register(HomeTableViewCell.nib(), forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableFoods.register(HomeFoodTableViewCell.nib(), forCellReuseIdentifier: HomeFoodTableViewCell.identifier)
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
        searching = false
        searchController.searchBar.text = ""
        self.showSpinner()
        interactor.getListFoods { listFoods in
            self.hideSpinner()
            self.listFoods = listFoods
            self.listFoodsOneSection.removeAll()
            self.filterListFoods.removeAll()
            for foods in listFoods {
                self.listFoodsOneSection.append(contentsOf: foods.foods)
                self.filterListFoods.append(contentsOf: foods.foods)
            }

            DispatchQueue.main.async {
                self.tableFoods.reloadData()
                self.refreshControl?.endRefreshing()
            }
        } completionError: {
            self.hideSpinner()
            self.refreshControl?.endRefreshing()
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
        if searching {
            return 1
        } else {
            return listFoods.count
        }
    }
    
    func getNumberOfRowsPerSections() -> Int {
        if searching {
            return filterListFoods.count
        } else {
            return 1
        }
    }
    
    func createCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        cell.selectionStyle = .none
        cell.parentVC = self
        cell.section = indexPath.section
        cell.foods = listFoods[indexPath.section].foods
        return cell
    }
    
    func createCellFilter(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeFoodTableViewCell.identifier, for: indexPath) as! HomeFoodTableViewCell
        cell.selectionStyle = .none
        cell.setupCell(nameImg: filterListFoods[indexPath.row].image, nameFood: filterListFoods[indexPath.row].name)
        return cell
    }
    
    func updateSearchResultsTable(searchText: String) {
        if !searchText.isEmpty {
            searching = true
            filterListFoods.removeAll()
            for item in listFoodsOneSection {
                if item.name.lowercased().contains(searchText.lowercased()) {
                    filterListFoods.append(item)
                }
            }
        } else {
            searching = false
            filterListFoods.removeAll()
            filterListFoods = listFoodsOneSection
        }
    }
    
    func actionSearchBarCancelButtonClicked() {
        searching = false
        filterListFoods.removeAll()
    }
    
}

// MARK: - UISearchResultsUpdating, UISearchBarDelegate
extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        updateSearchResultsTable(searchText: searchText)
        tableFoods.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        actionSearchBarCancelButtonClicked()
        tableFoods.reloadData()
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if searching {
            return UIView()
        } else {
            return createHeader(section: section, title: listFoods[section].type)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getNumberOfRowsPerSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searching {
            return createCellFilter(tableView: tableView, indexPath: indexPath)
        } else {
            return createCell(tableView: tableView, indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching {
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FoodDetailViewController") as? FoodDetailViewController else { return }
            vc.food = filterListFoods[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if searching {
            return 0
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

// MARK: - @objc
extension HomeViewController {
    
    @objc func refreshFoods() {
        self.getListFoods()
    }
    
}
