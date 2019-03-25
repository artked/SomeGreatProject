//
//  RestaurantModel.swift
//  SomeGreatProject
//
//  Created by Developer007  on 25.03.2019.
//  Copyright © 2019 alexey. All rights reserved.
//

import Foundation

struct RestaurantModel: Decodable {
    let restaurant: String
    let food_name: String
    let price: Float
    let image_url: String
}
