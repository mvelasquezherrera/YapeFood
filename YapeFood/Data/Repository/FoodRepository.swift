//
//  FoodRepository.swift
//  YapeFood
//
//  Created by Marcelo Stefano Velasquez Herrera on 4/03/23.
//

import Foundation

public class FoodRepository {
    
    let foodDS: FoodDataSourceProtocol
    
    init() {
        self.foodDS = FoodDataSource()
    }
    
}

extension FoodRepository: FoodRepositoryProtocol {
    
    func getListFoods(completion: @escaping ([FoodCategory]) -> Void, completionError: @escaping () -> Void) {
        self.foodDS.getListFoods(completion: completion, completionError: completionError)
    }
    
}
