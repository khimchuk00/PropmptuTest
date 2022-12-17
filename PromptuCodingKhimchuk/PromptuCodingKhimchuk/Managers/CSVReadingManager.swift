//
//  CSVReadingManager.swift
//  PromptuCodingKhimchuk
//
//  Created by Valentyn Khimchuk on 13.12.2022.
//

import Foundation

protocol ReadingProtocol {
    func readData() -> Result<[AirportModel], Error>
    func getAirport(by code: String) -> Result<AirportDetailedModel, Error>
}

class CSVReadingManager: ReadingProtocol {
    private var cachedData: [AirportDetailedModel] = []

    func readData() -> Result<[AirportModel], Error> {
        if cachedData.isEmpty {
            let result = readDataFromCSV(fileName: "airport", fileType: "csv")

            switch result {
            case .success(let data):
                let csvRows = csv(data: data)

                cachedData = csvRows.compactMap {
                    guard $0.count > 4 else { return nil }

                    return AirportDetailedModel(code: $0[0], timeZone: $0[1], city: $0[2], state: $0[3], name: $0[4])
                }

                let shortData = getShortData(data: cachedData)

                return .success(shortData)
            case .failure(let error):
                return .failure(error)
            }
        } else {
            let shortData = getShortData(data: cachedData)

            return .success(shortData)
        }
    }

    func getAirport(by code: String) -> Result<AirportDetailedModel, Error> {
        if let airportData = cachedData.first(where: { $0.code == code }) {
            return .success(airportData)
        } else {
            return .failure(DefaultError.airportDoesntExist)
        }
    }

    private func getShortData(data: [AirportDetailedModel]) -> [AirportModel] {
        cachedData.compactMap { AirportModel(code: $0.code, timeZone: $0.timeZone, name: $0.name)}
    }

    private func readDataFromCSV(fileName:String, fileType: String) -> Result<String, Error> {
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
        else {
            return .failure(DefaultError.fileDoesntExist)
        }
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = cleanRows(file: contents)
            return .success(contents)
        } catch {
            print("File Read Error for file \(filepath)")
            return .failure(DefaultError.wrongData)
        }
    }

    private func cleanRows(file: String) -> String {
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }

    private func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: "\t")
            result.append(columns)
        }
        return result
    }
}
