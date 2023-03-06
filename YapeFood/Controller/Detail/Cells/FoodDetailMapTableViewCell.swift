//
//  FoodDetailMapTableViewCell.swift
//  YapeFood
//
//  Created by Marcelo Stefano Velasquez Herrera on 6/03/23.
//

import UIKit
import MapKit

class FoodDetailMapTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mapa: MKMapView!
    
    static let identifier = "FoodDetailMapTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "FoodDetailMapTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - SETUP VIEW
extension FoodDetailMapTableViewCell {
    
    func setAnnotation(origin: String, latitude: String, longitude: String) {
        let coordinateOrigin = MKPointAnnotation()
        coordinateOrigin.title = origin
        coordinateOrigin.coordinate = CLLocationCoordinate2D(latitude: Double(latitude) ?? 0, longitude: Double(longitude) ?? 0)
        let coordinateRegion = MKCoordinateRegion(center: coordinateOrigin.coordinate, latitudinalMeters: 50, longitudinalMeters: 50)
        mapa.addAnnotation(coordinateOrigin)
        mapa.setRegion(coordinateRegion, animated: true)
    }
    
}
