//
//  CityModelData.swift
//  ProximityTest
//
//  Created by Anuj Joshi on 19/10/2021.
//

import Foundation

protocol CityModelData {
    var city: String { get set }
    var history: [AirQualityModel] { get set }
}

class CityDetailsModelData: CityModelData {
    var city: String
    var history: [AirQualityModel] = [AirQualityModel]()

    init(city: String) {
        self.city = city
    }
}
