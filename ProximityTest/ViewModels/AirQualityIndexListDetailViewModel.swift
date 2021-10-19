//
//  AirQualityIndexListDetailViewModel.swift
//  ProximityTest
//
//  Created by Anuj Joshi on 19/10/2021.
//

import Foundation
import RxSwift
import RxCocoa
import Starscream

class AirQualityIndexListDetailViewModel {

    private var city: String = ""

    var prevItem: CityDetailsModelData? = nil

    var item = PublishSubject<CityDetailsModelData>()

    var provider: AirQualityIndexDataProvider?

    init(dataProvider: AirQualityIndexDataProvider) {
        provider = dataProvider
        provider?.delegate = self
    }

    func subscribe(forCity: String) {
        self.city = forCity
        provider?.subscribe()
    }
    func unsubscribe() {
        provider?.unsubscribe()
    }
}

extension AirQualityIndexListDetailViewModel: AirQualityIndexDataProviderDelegate {
    func didReceive(response: Result<[AirQualityResposne], Error>) {
        switch response {

        case .success(let response):
            parseAndNotify(resArray: response)

        case .failure(let error):
            handleError(error: error)
        }
    }

    func parseAndNotify(resArray: [AirQualityResposne]) {

        let cityData = resArray.filter { $0.city == city }
        if let data = cityData.first {
            if let prev = prevItem {
                prev.history.append(AirQualityModel(value: data.aqi, date: Date()))
            } else {
                prevItem = CityDetailsModelData(city: self.city)
                prevItem?.history.append(AirQualityModel(value: data.aqi, date: Date()))
            }
        } else {
            if let prev = prevItem, let last = prev.history.last {
                prev.history.append(last)
            }
        }

        if let p = prevItem {
            item.onNext(p)
        }
    }

    func handleError(error: Error?) {
        if let e = error {
            item.onError(e)
        }
    }
}
