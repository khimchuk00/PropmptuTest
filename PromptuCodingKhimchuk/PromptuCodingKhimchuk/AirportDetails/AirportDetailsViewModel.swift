//
//  AirportDetailsViewModel.swift
//  PromptuCodingKhimchuk
//
//  Created by Valentyn Khimchuk on 13.12.2022.
//

import Foundation

protocol AirportDetailsViewModelProtocol {
    var onDataLoaded: ((AirportDetailedModel) -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
    func loadData()
}

class AirportDetailsViewModel: AirportDetailsViewModelProtocol {
    var onDataLoaded: ((AirportDetailedModel) -> Void)? 
    var onError: ((Error) -> Void)?

    private(set) var readingManager: ReadingProtocol
    private(set) var code: String

    required init(readingManager: ReadingProtocol, code: String) {
        self.readingManager = readingManager
        self.code = code
    }

    func loadData() {
        let data = readingManager.getAirport(by: code)

        switch data {
        case .success(let data):
            onDataLoaded?(data)
        case .failure(let error):
            onError?(error)
        }
    }
}
