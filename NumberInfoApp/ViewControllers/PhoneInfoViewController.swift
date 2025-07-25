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
        networkManager.fetch(from: URL(string: "\(Link.baseUrl.url + inputUser)")!) { [unowned self] result in
            switch result {
            case .success(let info):
                activityIndicator.stopAnimating()
                phoneInfoLabel.isHidden = false
                title = info.number
                phoneInfoLabel.text = info.description
            case .failure(let error):
                print(error)
            }
        }
    }
}
