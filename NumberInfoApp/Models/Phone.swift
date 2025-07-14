//
//  Phone.swift
//  NumberInfoApp
//
//  Created by Alexandr Artemov (Mac Mini) on 15.07.2025.
//

struct Phone: Decodable {
    let valid: Bool
    let number: String
    let local_format: String
    let international_format: String
    let country_prefix: String
    let country_code: String
    let country_name: String
    let location: String
    let carrier: String
    let line_type: String
}
