//
//  AirQualityIndexListDetailModelTest.swift
//  ProximityTestTests
//
//  Created by Anuj Joshi on 19/10/2021.
//

import XCTest
import RxSwift
import RxNimble
import Nimble

@testable import ProximityTest

//// MARK: tests fake data
let fakeResponseForDetails: [AirQualityResposne] = [AirQualityResposne(city: "Delhi", aqi: 200.0)]
let fakeDataProviderForDetails: AirQualityIndexDataProvider = FakeDataProvider(fakeResponse: .success(fakeResponseForDetails))

let fakeDataProviderForDetailsWithError: AirQualityIndexDataProvider
    = FakeDataProvider(fakeResponse: .failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey : "error message"])))

class AirQualityIndexListDetailModelTest: XCTestCase {

    let detailViewModel: AirQualityIndexListDetailViewModel = AirQualityIndexListDetailViewModel(dataProvider: fakeDataProviderForDetails)

    let detailViewModelError: AirQualityIndexListDetailViewModel = AirQualityIndexListDetailViewModel(dataProvider: fakeDataProviderForDetailsWithError)

    func testRespnoseDataInformation() {

        detailViewModel.subscribe(forCity: "Delhi")

        expect(self.detailViewModel.prevItem?.city) == fakeResponse.first?.city
        expect(self.detailViewModel.prevItem?.history.last?.value) == fakeResponse.first?.aqi

        detailViewModel.unsubscribe()
    }

    func testDataInformationWhenPrevItemsAvailable() {

        let item = CityDetailsModelData(city: "Mumbai")
        item.history = [AirQualityModel(value: 100, date: Date())]
        detailViewModel.prevItem = item

        detailViewModel.subscribe(forCity: "Mumbai")

        expect(self.detailViewModel.prevItem?.city) == "Mumbai"
        expect(self.detailViewModel.prevItem?.history.last?.value) == 100

        detailViewModel.unsubscribe()
    }

    func testErrorResponse() {

        detailViewModelError.subscribe(forCity: "Delhi")

        _ = self.detailViewModelError.prevItem
       // expect(p) == nil

    }
}

