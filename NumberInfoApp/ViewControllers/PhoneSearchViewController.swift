//
//  PhoneSearchViewController.swift
//  NumberInfoApp
//
//  Created by Alexandr Artemov (Mac Mini) on 15.07.2025.
//

import UIKit

final class PhoneSearchViewController: UIViewController {
    
    //MARK: - IB Outlet
    @IBOutlet var phoneNumberTextField: UITextField!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumberTextField.clearButtonMode = .whileEditing
    }
    
    //MARK: - Overrides
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? PhoneInfoViewController else  {
            return
        }
        detailVC.inputUser = phoneNumberTextField.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    //MARK: - IB Action
    @IBAction func searchButtonTapped() {
        guard
            let number = phoneNumberTextField.text,
            isValidInternationalPhoneNumber(number)
        else {
            showAlert(
                title: "Ошибка",
                message: "Введите корректный номер телефона в формате +123456789") {
                    self.phoneNumberTextField.text = ""
                }
            return
        }
        
        performSegue(withIdentifier: "showPhoneInfo", sender: self)
    }
    
    //MARK: - Private Methods
    private func showAlert(
        title: String,
        message: String,
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ок", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func isValidInternationalPhoneNumber(_ number: String) -> Bool {
        let pattern = #"^\+[0-9]{8,15}$"#
        return number.range(of: pattern, options: .regularExpression) != nil
    }
}
