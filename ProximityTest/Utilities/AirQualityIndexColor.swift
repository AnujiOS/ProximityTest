//
//  AirQualityIndexColor.swift
//  ProximityTest
//
//  Created by Anuj Joshi on 19/10/2021.
//

import UIKit

struct AirQualityIndexColor {
    static func color(index: AirQualityIndexType) -> UIColor {
        switch index {

        case .good:
            return UIColor(hexString: "#55A84F")

        case .satisfactory:
            return UIColor(hexString: "#A3C853")

        case .moderate:
            return UIColor(hexString: "#FCF834")

        case .poor:
            return UIColor(hexString: "#EE9A32")

        case .veryPoor:
            return UIColor(hexString: "#DE3B30")

        case .severe:
            return UIColor(hexString: "#A72B22")

        case .outOfRange:
            return UIColor(hexString: "#A72B22")

        }
    }
}
