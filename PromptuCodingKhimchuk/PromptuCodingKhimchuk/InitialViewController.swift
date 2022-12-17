//
//  InitialViewController.swift
//  PromptuCodingKhimchuk
//
//  Created by Valentyn Khimchuk on 13.12.2022.
//

import UIKit

class InitialViewController: UIViewController {
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        MainCoordinator(presenter: self).start()
    }
}
