//
//  ViewController.swift
//  NumberInfoApp
//
//  Created by Alexandr Artemov (Mac Mini) on 15.07.2025.
//

import UIKit

final class ViewController: UIViewController {

    private let link = "https://apilayer.net/api/validate?access_key=ed268fd18b92c030907e2edccb9b8764&number=+7(499)956-99-99"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPhoneInfo()
    }

}

// MARK: - Networking
extension ViewController {
    private func fetchPhoneInfo() {
        URLSession.shared.dataTask(with: URL(string: link)!) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description.")
                return
            }
            
            do {
                let phoneNumberInfo = try JSONDecoder().decode(Phone.self, from: data)
                print(phoneNumberInfo)
            } catch {
                print(error)
            }
        }.resume()
    }
}
