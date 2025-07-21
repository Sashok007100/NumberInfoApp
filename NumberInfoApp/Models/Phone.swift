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
}

enum LineType: Decodable {
    case mobile
    case landline
    case specialServices
    case tollFree
    case premiumRate
    case satellite
    case paging
    case unknown(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let raw = (try? container.decode(String.self)) ?? ""
        let normalized = raw.replacingOccurrences(of: "_", with: "").lowercased()

        switch normalized {
        case "mobile": self = .mobile
        case "landline": self = .landline
        case "specialservices": self = .specialServices
        case "tollfree": self = .tollFree
        case "premiumrate": self = .premiumRate
        case "satellite": self = .satellite
        case "paging": self = .paging
        default: self = .unknown(raw)
        }
    }

    var localizedDescription: String {
        switch self {
        case .mobile: return "Мобильный"
        case .landline: return "Стационарный"
        case .specialServices: return "Служебный номер"
        case .tollFree: return "Бесплатный"
        case .premiumRate: return "Премиум-номер"
        case .satellite: return "Спутник"
        case .paging: return "Пейджер"
        case .unknown(let raw): return "Неизвестно (\(raw))"
        }
    }
}
