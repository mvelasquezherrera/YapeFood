//
//  FoodMapViewController.swift
//  YapeFood
//
//  Created by Marcelo Stefano Velasquez Herrera on 6/03/23.
//

import UIKit
import MapKit

class FoodMapViewController: BaseViewController {
    
    @IBOutlet weak var mapa: MKMapView!
    
    var food: Foods?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
        setAnnotation(origin: food?.origin ?? "", latitude: food?.latitude ?? "", longitude: food?.longitude ?? "")
    }

}

// MARK: - SETUP VIEW
extension FoodMapViewController {
    
    func setupNavigationController() {
        self.title = food?.name ?? ""
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setAnnotation(origin: String, latitude: String, longitude: String) {
        let coordinateOrigin = MKPointAnnotation()
        coordinateOrigin.title = origin
        coordinateOrigin.coordinate = CLLocationCoordinate2D(latitude: Double(latitude) ?? 0, longitude: Double(longitude) ?? 0)
        let coordinateRegion = MKCoordinateRegion(center: coordinateOrigin.coordinate, latitudinalMeters: 50, longitudinalMeters: 50)
        mapa.addAnnotation(coordinateOrigin)
        mapa.setRegion(coordinateRegion, animated: true)
    }
    
}
