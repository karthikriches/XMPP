//
//  Weather.swift
//  XMPP
//
//  Created by Karthik on 19/04/21.
//

import Foundation

struct Root: Codable {
    let message, cod: String
    let count: Int
    let list: [Weather]
}

// MARK: - List
struct Weather: Codable {
    let id: Int
    let name: String
    let main: City

}

struct City: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}
