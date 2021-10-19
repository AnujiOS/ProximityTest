//
//  AirQualityCityListVC.swift
//  ProximityTest
//
//  Created by Anuj Joshi on 19/10/2021.
//

import UIKit
import RxSwift
import RxCocoa

class AirQualityCityListVC: UIViewController {

    private var viewModel: AirQualityIndexListViewModel?

    private var bag = DisposeBag()

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.accessibilityIdentifier = "table--cityTableView"

        viewModel = AirQualityIndexListViewModel(dataProvider: AirQualityIndexDataProvider())

        bindTableData()
    }

    func bindTableData() {

        // bind items to table
        viewModel?.items.bind(to: tableView.rx.items(cellIdentifier: "AirQualityCityListCell", cellType: AirQualityCityListCell.self)) {row, model, cell in

            cell.cityData = model

        }.disposed(by: bag)

        // bind a model selected handler
        tableView.rx.modelSelected(CityDetailsModelData.self).bind { item in

            let cityDetail: AirQualityIndexGraphVC = self.storyboard?.instantiateViewController(identifier: "AirQualityIndexGraphVC") as! AirQualityIndexGraphVC
            cityDetail.cityModel = item
            self.navigationController?.pushViewController(cityDetail, animated: true)

        }.disposed(by: bag)


        // set delegate
        tableView
            .rx.setDelegate(self)
            .disposed(by: bag)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // subscribe to AQIs Socket Connection
        viewModel?.subscribe()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // unsubscribe
        viewModel?.unsubscribe()
    }

    deinit {
        // unsubscribe
        viewModel?.unsubscribe()
    }

}

extension AirQualityCityListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}

