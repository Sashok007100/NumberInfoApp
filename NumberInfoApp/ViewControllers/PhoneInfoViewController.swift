//
//  PhoneInfoViewController.swift
//  NumberInfoApp
//
//  Created by Alexandr Artemov (Mac Mini) on 21.07.2025.
//

import UIKit

final class PhoneInfoViewController: UIViewController {
    
    @IBOutlet var phoneInfoLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private let networkManager = NetworkManager.shared
    
    var inputUser: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        fetchPhoneInfo()
    }
}

// MARK: - Networking
extension PhoneInfoViewController {
    private func fetchPhoneInfo() {
        let url = URL(string: "https://apilayer.net/api/validate?access_key=ed268fd18b92c030907e2edccb9b8764&number=\(inputUser ?? "")")!
        
        networkManager.fetch(from: url) { [unowned self] result in
            switch result {
            case .success(let info):
                activityIndicator.stopAnimating()
                phoneInfoLabel.isHidden = false
                title = info.number
                phoneInfoLabel.text = """
                    Действительный номер: \(info.valid ? "✅ Да" : "❌ Нет")
                    Местный формат: \(!info.localFormat.isEmpty ? info.localFormat : "Неизвестно")
                    Международный формат: \(!info.internationalFormat.isEmpty ? info.internationalFormat : "Неизвестно")
                    Международный код: \(!info.countryPrefix.isEmpty ? info.countryPrefix : "Неизвестно")
                    Буквенный код страны: \(!info.countryCode.isEmpty ? info.countryCode : "Неизвестно")
                    Страна: \(!info.countryName.isEmpty ? info.countryName : "Неизвестно")
                    Город: \(!info.location.isEmpty ? info.location : "Неизвестно")
                    Оператор: \(!info.carrier.isEmpty ? info.carrier : "Неизвестно")
                    Тип связи: \(info.lineType?.rawValue ?? "Неизвестно")
                    """
            case .failure(let error):
                print(error)
            }
        }
    }
}
