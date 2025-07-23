//
//  NetworkManager.swift
//  NumberInfoApp
//
//  Created by Alexandr Artemov (Mac Mini) on 21.07.2025.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch(from url: URL, completion: @escaping(Result<Phone, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error ?? "No error description")
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let phoneInfo = try decoder.decode(Phone.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(phoneInfo))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
