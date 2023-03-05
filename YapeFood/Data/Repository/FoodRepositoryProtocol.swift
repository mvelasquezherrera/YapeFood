//
//  FoodRepositoryProtocol.swift
//  YapeFood
//
//  Created by Marcelo Stefano Velasquez Herrera on 4/03/23.
//

import Foundation

protocol FoodRepositoryProtocol {
    func getListFoods(completion: @escaping ([FoodCategory]) -> Void, completionError: @escaping () -> Void)
}
