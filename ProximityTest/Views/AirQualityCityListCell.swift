//
//  AirQualityCityListCell.swift
//  ProximityTest
//
//  Created by Anuj Joshi on 19/10/2021.
//

import UIKit

class AirQualityCityListCell: UITableViewCell {

    @IBOutlet var lblCity: UILabel?
    @IBOutlet var lblAQI: UILabel?
    @IBOutlet var lblLastUpdated: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()

        lblAQI?.layer.cornerRadius = 5
        lblAQI?.layer.masksToBounds = true
    }

    var cityData: CityDetailsModelData? {
        didSet {
            guard let cityData = cityData else { return }
            lblCity?.text = cityData.city

            if let aqi = cityData.history.last?.value {
                lblAQI?.text = String(format: "%.2f", aqi)
            }

            if let aqi = cityData.history.last?.value {
                let index = AirQualityIndexTypeClassifier.classifyAirQualityIndex(aqi: aqi)
                lblAQI?.backgroundColor = AirQualityIndexColor.color(index: index)
            }

            if let date = cityData.history.last?.date {
                if date.timeAgo() == "0 seconds" {
                    lblLastUpdated?.text = "just now"
                } else {
                    lblLastUpdated?.text = date.timeAgo() + " ago"
                }
            }

            self.accessibilityLabel = cityData.city
            self.accessibilityIdentifier = cityData.city
            self.accessibilityTraits = [.button]
        }
    }
}
