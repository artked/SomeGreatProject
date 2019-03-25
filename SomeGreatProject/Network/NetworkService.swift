//
//  NetworkService.swift
//  SomeGreatProject
//
//  Created by Developer007  on 25.03.2019.
//  Copyright © 2019 alexey. All rights reserved.
//

import Foundation

protocol GreatAPI {
    @discardableResult func fetchRestaurants(withPage page: Int, completion: @escaping ([RestaurantModel]) -> ()) -> URLSessionDataTask
}

final class NetworkService: GreatAPI {
    
    private let session = URLSession.shared
    
    let kBaseURL = "https://gist.githubusercontent.com"
    
    let dataEndpoint = "/gonchs/b657e6043e17482cae77a633d78f8e83/raw/7654c0db94a3f430888fac0caac675c7e811030a/test_data.json"
    
    @discardableResult
    func fetchRestaurants(withPage page: Int, completion: @escaping ([RestaurantModel]) -> ()) -> URLSessionDataTask {
        
        //В задании была фраза "Scrolling down will show more items"
        //Предполагаю что возможно понадобиться пагинация
        //Добавил параметр page
        
        var request = URLRequest(url: URL(string: kBaseURL + dataEndpoint)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request) { (data, _, _) in
            
                guard let data = data,
                    let response = try? JSONDecoder().decode([RestaurantModel].self, from: data) else {
                        completion([])
                        return
                }
                completion(response)
            
        }
        task.resume()
        return task
        
    }
   
    
}
