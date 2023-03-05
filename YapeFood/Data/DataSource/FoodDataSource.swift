//
//  FoodDataSource.swift
//  YapeFood
//
//  Created by Marcelo Stefano Velasquez Herrera on 4/03/23.
//

import Foundation

public class FoodDataSource: FoodDataSourceProtocol {
    
    func getListFoods(completion: @escaping ([FoodCategory]) -> Void, completionError: @escaping () -> Void) {
        
        let url = URL(string: "\(Constants.request.baseURL)listFoods")
        guard let url = url else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let unwrappedData = data else { return }
            do {
                let value = try JSONDecoder().decode([FoodCategory].self, from: unwrappedData)
                let response = response as! HTTPURLResponse
                let status = response.statusCode
                switch status {
                case 200...299:
                    completion(value)
                    break
                default:
                    completionError()
                    break
                }
            } catch {
                print("json error: \(error)")
                completionError()
            }
        }.resume()
        
        
    }
    
}
