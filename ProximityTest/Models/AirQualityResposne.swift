//
//  AirQualityResposne.swift
//  ProximityTest
//
//  Created by Anuj Joshi on 19/10/2021.
//

import Foundation

struct AirQualityResposne: Codable {
    var city: String
    var aqi: Float
    init(city: String, aqi: Float) {
        self.city = city
        self.aqi = aqi
    }
}
