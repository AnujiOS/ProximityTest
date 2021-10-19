//
//  AirQualityModel.swift
//  ProximityTest
//
//  Created by Anuj Joshi on 19/10/2021.
//

import Foundation

class AirQualityModel {
    var value: Float = 0.0
    var date: Date = Date()
    init(value: Float, date: Date) {
        self.value = value
        self.date = date
    }
}
