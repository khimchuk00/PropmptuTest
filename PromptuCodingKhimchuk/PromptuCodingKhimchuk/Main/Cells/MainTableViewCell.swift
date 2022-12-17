//
//  MainTableViewCell.swift
//  PromptuCodingKhimchuk
//
//  Created by Valentyn Khimchuk on 13.12.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timezoneLabel: UILabel!

    func configure(airport: AirportModel) {
        nameLabel.text = airport.name
        timezoneLabel.text = airport.timeZone
    }
}
