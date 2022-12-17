//
//  AirportDetailsViewController.swift
//  PromptuCodingKhimchuk
//
//  Created by Valentyn Khimchuk on 13.12.2022.
//

import UIKit

class AirportDetailsViewController: UIViewController, AlertPresentableVC {
    // MARK: - Outlets
    @IBOutlet weak var airportCode: UILabel!
    @IBOutlet weak var timezoneLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var airportName: UILabel!

    var viewModel: AirportDetailsViewModelProtocol?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupListeners()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel?.loadData()
    }

    // MARK: - Private methods
    private func setupListeners() {
        viewModel?.onError = { [weak self] errorDetails in
            self?.presentAlert(text: "Something went wrong", description: errorDetails.localizedDescription)
        }

        viewModel?.onDataLoaded = { [weak self] data in
            self?.airportName.text = data.name
            self?.airportCode.text = data.code
            self?.timezoneLabel.text = data.timeZone
            self?.stateLabel.text = data.state
            self?.cityLabel.text = data.city
        }
    }
}

// MARK: - StoryboardController
extension AirportDetailsViewController: StoryboardController {
    static var storyboard: Storyboard {
        .AirportDetails
    }
}
