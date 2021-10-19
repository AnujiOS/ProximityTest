//
//  AirQualityIndexListViewModel.swift
//  ProximityTest
//
//  Created by Anuj Joshi on 19/10/2021.
//

import Foundation
import RxSwift
import RxCocoa

class AirQualityIndexListViewModel {

    var prevItems: [CityDetailsModelData] = [CityDetailsModelData]()

    var items = PublishSubject<[CityDetailsModelData]>()

    var provider: AirQualityIndexDataProvider?

    init(dataProvider: AirQualityIndexDataProvider) {
        provider = dataProvider
        provider?.delegate = self
    }

    func subscribe() {
        provider?.subscribe()
    }

    func unsubscribe() {
        provider?.unsubscribe()
    }
}

extension AirQualityIndexListViewModel: AirQualityIndexDataProviderDelegate {
    func didReceive(response: Result<[AirQualityResposne], Error>) {
        switch response {

        case .success(let response):
            parseAndNotify(resArray: response)

        case .failure(let error):
            handleError(error: error)
        }
    }

    func parseAndNotify(resArray: [AirQualityResposne]) {

        if prevItems.count == 0 {
            for d in resArray {
                let m = CityDetailsModelData(city: d.city)
                m.history.append(AirQualityModel(value: d.aqi, date: Date()))
                prevItems.append(m)
            }
        } else {

            for res in resArray {
                let matchedResults = prevItems.filter { $0.city == res.city }
                if let matchedRes = matchedResults.first {
                    matchedRes.history.append(AirQualityModel(value: res.aqi, date: Date()))
                } else {
                    let m = CityDetailsModelData(city: res.city)
                    m.history.append(AirQualityModel(value: res.aqi, date: Date()))
                    prevItems.append(m)
                }
            }
        }

        items.onNext(prevItems)
    }

    func handleError(error: Error?) {
        if let e = error {
            items.onError(e)
        }
    }
}
