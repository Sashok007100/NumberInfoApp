//
//  Phone.swift
//  NumberInfoApp
//
//  Created by Alexandr Artemov (Mac Mini) on 15.07.2025.
//

struct Phone {
    let valid: Bool
    let number: String
    let localFormat: String
    let internationalFormat: String
    let countryPrefix: String
    let countryCode: String
    let countryName: String
    let location: String
    let carrier: String
    let lineType: LineType?
    
    var description: String {
                        """
                            Действительный номер: \(valid ? "✅ Да" : "❌ Нет")
                            Местный формат: \(!localFormat.isEmpty ? localFormat : "Неизвестно")
                            Международный формат: \(!internationalFormat.isEmpty ? internationalFormat : "Неизвестно")
                            Международный код: \(!countryPrefix.isEmpty ? countryPrefix : "Неизвестно")
                            Буквенный код страны: \(!countryCode.isEmpty ? countryCode : "Неизвестно")
                            Страна: \(!countryName.isEmpty ? countryName : "Неизвестно")
                            Город: \(!location.isEmpty ? location : "Неизвестно")
                            Оператор: \(!carrier.isEmpty ? carrier : "Неизвестно")
                            Тип связи: \(lineType?.rawValue ?? "Неизвестно")
                            """
    }
    
    init(phoneInfo: [String: Any]) {
        valid = phoneInfo["valid"] as? Bool ?? false
        number = phoneInfo["number"] as? String ?? ""
        localFormat = phoneInfo["local_format"] as? String ?? ""
        internationalFormat = phoneInfo["international_format"] as? String ?? ""
        countryPrefix = phoneInfo["country_prefix"] as? String ?? ""
        countryCode = phoneInfo["country_code"] as? String ?? ""
        countryName = phoneInfo["country_name"] as? String ?? ""
        location = phoneInfo["location"] as? String ?? ""
        carrier = phoneInfo["carrier"] as? String ?? ""
        if let value = phoneInfo["line_type"] as? String {
            lineType = LineType(from: value)
        } else {
            lineType = LineType.unknown
        }
    }
    
    static func getPhoneInfo(from value: Any) -> Phone {
        let phoneDetails = value as? [String: Any] ?? [:]
        return Phone(phoneInfo: phoneDetails)
    }
}

enum LineType: String {
    case mobile = "Мобильный"
    case landline = "Стационарный"
    case specialServices = "Служебный номер"
    case tollFree = "Бесплатный"
    case premiumRate = "Премиум-номер"
    case satellite = "Спутник"
    case paging = "Пейджер"
    case unknown = "Неизвестно"
    
    init(from string: String) {
        switch string {
        case "mobile": self = .mobile
        case "landline": self = .landline
        case "special_services": self = .specialServices
        case "toll_free": self = .tollFree
        case "premium_rate": self = .premiumRate
        case "satellite": self = .satellite
        case "paging": self = .paging
        default:
            self = .unknown
        }
    }
}
