//
//  AirportListViewModel.swift
//  PromptuCodingKhimchuk
//
//  Created by Valentyn Khimchuk on 13.12.2022.
//

import Foundation

protocol AirportListViewModelProtocol {
    var onAirportDetails: ((AirportModel, ReadingProtocol, String) -> Void)? { get set }
    var onDataLoaded: (([AirportModel]) -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
    var readingManager: ReadingProtocol { get set }
    func loadData()
}

class AirportListViewModel: AirportListViewModelProtocol {
    var onAirportDetails: ((AirportModel, ReadingProtocol, String) -> Void)?
    var onDataLoaded: (([AirportModel]) -> Void)?
    var onError: ((Error) -> Void)?
    var readingManager: ReadingProtocol

    required init(readingManager: ReadingProtocol) {
        self.readingManager = readingManager
    }

    func loadData() {
        let data = readingManager.readData()

        switch data {
        case .success(let data):
            onDataLoaded?(data)
        case .failure(let error):
            onError?(error)
        }
    }
}
