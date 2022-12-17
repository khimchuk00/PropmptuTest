//
//  AirportDetailsCoordinator.swift
//  PromptuCodingKhimchuk
//
//  Created by Valentyn Khimchuk on 13.12.2022.
//

import UIKit

class AirportDetailsCoordinator: Coordinator {
    // MARK: - Dependencies
    var controller: AirportDetailsViewController
    var presenter: UIViewController

    private var reader: ReadingProtocol
    private var code: String

    init(presenter: UIViewController, reader: ReadingProtocol, code: String) {
        self.presenter = presenter
        self.reader = reader
        self.code = code
        controller = AirportDetailsViewController.fromStoryboard
    }

    func start() {
        controller.viewModel = viewModel
        controller.modalPresentationStyle = .popover
        presenter.present(controller, animated: true)
    }

    var viewModel: AirportDetailsViewModel {
        let viewModel = AirportDetailsViewModel(readingManager: reader, code: code)

        return viewModel
    }
}
