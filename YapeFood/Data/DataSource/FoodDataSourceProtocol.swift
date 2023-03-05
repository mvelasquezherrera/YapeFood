//
//  FoodDataSourceProtocol.swift
//  YapeFood
//
//  Created by Marcelo Stefano Velasquez Herrera on 4/03/23.
//

import Foundation

protocol FoodDataSourceProtocol {
    func getListFoods(completion: @escaping ([FoodCategory]) -> Void, completionError: @escaping () -> Void)
}
