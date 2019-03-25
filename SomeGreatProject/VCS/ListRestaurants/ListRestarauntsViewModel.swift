//
//  ListRestarauntsViewModel.swift
//  SomeGreatProject
//
//  Created by Developer007  on 25.03.2019.
//  Copyright © 2019 alexey. All rights reserved.
//

import Foundation

class ListRestarauntsViewModel {
    
    private let networkingService: NetworkService
    
    var isLoading: ((Bool) -> Void)?
    var didUpdateItems: (([RestaurantModel]) -> Void)?
    
    init(networkingService: NetworkService) {
        self.networkingService = networkingService
    }
    
    private(set) var items: [RestaurantModel] = [RestaurantModel]() {
        didSet {
            didUpdateItems!(items)
        }
    }
    
    func getName(row: Int) -> String {
        
        return items[row].restaurant
    }
    
    func getPrice(row: Int) -> String {
        return String(describing: items[row].price)
    }
    
    func getFoodName(row: Int) -> String {
        return items[row].food_name
    }
    
    func getImageURL(row: Int) -> String {
        return items[row].image_url
    }
    
    func fetchItems() {
        isLoading?(true)
        networkingService.fetchRestaurants(withPage: 0) { [weak self] (models) in
            guard let strongSelf  = self else { return }
            strongSelf.items.append(contentsOf: models)
            strongSelf.isLoading?(false)
        }
    }

}
