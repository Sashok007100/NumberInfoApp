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
    
    func fetch(from url: URL, completion: @escaping(Result<Phone, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    let phoneInfo = Phone.getPhoneInfo(from: data)
                    completion(.success(phoneInfo))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
