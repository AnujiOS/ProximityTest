//
//  AirQualityIndexType.swift
//  ProximityTest
//
//  Created by Anuj Joshi on 19/10/2021.
//

import UIKit

//MARK: Air Quality Index Types
enum AirQualityIndexType {
    case good
    case satisfactory
    case moderate
    case poor
    case veryPoor
    case severe
    case outOfRange
}

//MARK: Air Quality Index Type Classifier
class AirQualityIndexTypeClassifier {
    static func classifyAirQualityIndex(aqi: Float) -> AirQualityIndexType {
        switch aqi {

        case 0...50:
            return .good

        case 51...100:
            return .satisfactory

        case 101...200:
            return .moderate

        case 201...300:
            return .poor

        case 301...400:
            return .veryPoor

        case 401...500:
            return .severe

        default:
            return .outOfRange
        }
    }
}
