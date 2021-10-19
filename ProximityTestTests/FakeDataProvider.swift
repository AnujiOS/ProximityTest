//
//  FakeDataProvider.swift
//  ProximityTestTests
//
//  Created by Anuj Joshi on 19/10/2021.
//

import UIKit
import RxSwift

@testable import ProximityTest

typealias DataProviderResponse = Result<[AirQualityResposne], Error>

class FakeDataProvider: AirQualityIndexDataProvider {

    private var fakeResponse: DataProviderResponse

    var item = PublishSubject<CityDetailsModelData>()

    init(fakeResponse: DataProviderResponse) {
        self.fakeResponse = fakeResponse
    }

    override func subscribe() {
        notifyFakeResponse()
    }

    private func notifyFakeResponse() {
        switch self.fakeResponse {
        case .success(let res):
            self.delegate?.didReceive(response: .success(res))
        case .failure(let error):
            self.delegate?.didReceive(response: .failure(error))
        }
    }
}
