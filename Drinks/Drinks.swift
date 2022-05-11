//
//  Drinks.swift
//  Drinks
//
//  Created by Илья on 28.03.2022.
//

import Foundation
import Alamofire


class Drinks {
    
    struct Returned: Codable {
        var drinks: [Drink]
    }
    
    
    struct Drink: Codable {
        var strDrink = ""
    }
    
    
    let urlString = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic"
    var drinkArray: [Drink] = []
    
    
    func getData(completed: @escaping ()->()) {
        print("🕸 We are accessing the URL \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("😡 Could not create a URL from \(urlString)")
            completed()
            return
        }
        
        AF.request(url).response { response in
            guard let data = response.data else { return }
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data)
                self.drinkArray = returned.drinks
            } catch {
                print("😡 JSON ERROR: \(error.localizedDescription)")
            }
            completed()
        }
        .resume()
    }

    
}
