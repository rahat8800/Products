//
//  ApiManagerClass.swift
//  Project1
//
//  Created by Rahat on 25/04/24.
//

import Foundation

enum DataError:Error{
    case invalidResponse
    case invalidUrl
    case jsonParsingError
}
typealias type = (Result<[Product],DataError >) -> Void

class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func getProducts(handler: @escaping type){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            
            return }
        
        URLSession.shared.dataTask(with: url) { data , response, error in
            guard let data, error == nil else {
                handler(.failure(.invalidUrl ))
                return }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else { return  }
            
            do{
                let prod = try JSONDecoder().decode([Product].self, from: data)
                handler(.success(prod))
            }catch {
                // Handle the error
                    print("Error decoding JSON: \(error)")

                    // You can also pass the error to the completion handler if needed
                handler(.failure(.jsonParsingError))
            }
        }.resume()
    }
}
