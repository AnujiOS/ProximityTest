//
//  AirQualityIndexListModelTest.swift
//  ProximityTestTests
//
//  Created by Anuj Joshi on 19/10/2021.
//

import XCTest
import RxSwift
import RxNimble
import Nimble

@testable import ProximityTest

// MARK: tests fake data (success)
let fakeResponse: [AirQualityResposne] = [AirQualityResposne(city: "Delhi", aqi: 200.0)]
let fakeDataProvider: AirQualityIndexDataProvider = FakeDataProvider(fakeResponse: .success(fakeResponse))

let fakeDataProviderError: AirQualityIndexDataProvider
    = FakeDataProvider(fakeResponse: .failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey : "error message"])))

class AirQualityIndexListModelTest: XCTestCase {

    let listViewModel: AirQualityIndexListViewModel = AirQualityIndexListViewModel(dataProvider: fakeDataProvider)

    let listViewModelError: AirQualityIndexListViewModel = AirQualityIndexListViewModel(dataProvider: fakeDataProviderError)

    func testRespnoseDataInformation() {

        listViewModel.subscribe()

        expect(self.listViewModel.prevItems.first?.city) == fakeResponse.first?.city
        expect(self.listViewModel.prevItems.first?.history.last?.value) == fakeResponse.first?.aqi

        listViewModel.unsubscribe()
    }

    func testDataInformationWhenPrevItemsAvailable() {

        let item = CityDetailsModelData(city: "Mumbai")
        item.history = [AirQualityModel(value: 100, date: Date())]
        listViewModel.prevItems = [item]

        listViewModel.subscribe()

        expect(self.listViewModel.prevItems.first?.city) == "Mumbai"
        expect(self.listViewModel.prevItems.first?.history.last?.value) == 100

        listViewModel.unsubscribe()
    }

    func testErrorResponse() {

        listViewModelError.subscribe()

        let p = self.listViewModelError.prevItems
        expect(p.count) == 0

    }

}
