//
//  MainCoordinator.swift
//  PromptuCodingKhimchuk
//
//  Created by Valentyn Khimchuk on 13.12.2022.
//

import UIKit

class MainCoordinator: Coordinator {
    // MARK: - Dependencies
    var controller: ViewController
    var presenter: UIViewController

    init(presenter: UIViewController) {
        self.presenter = presenter
        controller = ViewController.fromStoryboard
    }

    func start() {
        controller.viewModel = viewModel
        controller.modalPresentationStyle = .fullScreen
        presenter.present(controller, animated: true)
    }

    var viewModel: AirportListViewModel {
        let viewModel = AirportListViewModel(readingManager: CSVReadingManager())

        viewModel.onAirportDetails = { [controller] airport, reader, code in
            AirportDetailsCoordinator(presenter: controller, reader: reader, code: code).start()
        }

        return viewModel
    }
}
