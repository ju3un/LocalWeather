//
//  Location.swift
//  LocalWeather
//
//  Created by ju3un on 2021/01/06.
//

import Foundation

struct Location: Codable {
    let name: String
    let woeid: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case woeid = "woeid"
    }
}
