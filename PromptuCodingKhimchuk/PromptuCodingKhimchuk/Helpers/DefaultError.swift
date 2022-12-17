//
//  DefaultError.swift
//  PromptuCodingKhimchuk
//
//  Created by Valentyn Khimchuk on 13.12.2022.
//

import Foundation

enum DefaultError: LocalizedError {
    case fileDoesntExist
    case wrongData
    case airportDoesntExist
    case message(message: String)

    var errorDescription: String? {
        switch self {
        case .fileDoesntExist:
            return "File doesn't exist"
        case .airportDoesntExist:
            return "Airport doesn't exist"
        case .wrongData:
            return "Can't read data from cvs"
        case .message(message: let message):
            return message
        }
    }
}
