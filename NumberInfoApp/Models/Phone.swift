//
//  Phone.swift
//  NumberInfoApp
//
//  Created by Alexandr Artemov (Mac Mini) on 15.07.2025.
//

struct Phone: Decodable {
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
    
}

enum LineType: String, Decodable {
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
