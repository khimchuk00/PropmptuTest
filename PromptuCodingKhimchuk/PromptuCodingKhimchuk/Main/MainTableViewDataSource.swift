//
//  MainTableViewDataSource.swift
//  PromptuCodingKhimchuk
//
//  Created by Valentyn Khimchuk on 13.12.2022.
//

import UIKit

protocol MainTableViewDelegate: AnyObject {
    var viewController: ViewController { get }
    func showDetails(airport: AirportModel)
}

protocol MainTableViewDataSource {
    func configure(with tableView: UITableView)
    func update(with airports: [AirportModel])
}

class MainTableViewDataSourceAdapter: NSObject, MainTableViewDataSource {
    // MARK: - NsEmailDetailsTableViewDelegate
    weak var delegate: MainTableViewDelegate?

    // MARK: - Sections
    private var dataSource: [AirportModel] = []

    init(delegate: MainTableViewDelegate?) {
        self.delegate = delegate
    }

    func configure(with tableView: UITableView) {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: MainTableViewCell.self)
        tableView.showsVerticalScrollIndicator = false
    }

    func update(with airports: [AirportModel]) {
        dataSource = airports
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension MainTableViewDataSourceAdapter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.cell(cellType: MainTableViewCell.self)
            cell.selectionStyle = .none
            cell.configure(airport: dataSource[indexPath.row])

            return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.showDetails(airport: dataSource[indexPath.row])
    }
}
