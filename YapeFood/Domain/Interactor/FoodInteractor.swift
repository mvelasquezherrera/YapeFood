//
//  FoodInteractor.swift
//  YapeFood
//
//  Created by Marcelo Stefano Velasquez Herrera on 4/03/23.
//

import Foundation

public class FoodInteractor {
    
    let foodRepository: FoodRepositoryProtocol
    
    init(foodRepository: FoodRepositoryProtocol) {
        self.foodRepository = foodRepository
    }
    
}

extension FoodInteractor: FoodInteractorProtocol {
    
    func getListFoods(completion: @escaping ([FoodCategory]) -> Void, completionError: @escaping () -> Void) {
        self.foodRepository.getListFoods(completion: completion, completionError: completionError)
    }
    
}
