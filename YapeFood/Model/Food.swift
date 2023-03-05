//
//  Food.swift
//  YapeFood
//
//  Created by Marcelo Stefano Velasquez Herrera on 4/03/23.
//

import UIKit

struct FoodCategory: Codable {
    let type: String
    let foods: [Foods]
}

struct Foods: Codable {
    let id: Int
    let image: String
    let name: String
    let description: String
    let ingredients: [FoodsIngredients]
    let preparation: String
    let origin: String
    let latitude: String
    let longitude: String
}

struct FoodsIngredients: Codable {
    let idIngredient: Int
    let nameIngredient: String
}
