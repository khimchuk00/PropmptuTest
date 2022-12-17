//
//  ViewController.swift
//  PromptuCodingKhimchuk
//
//  Created by Valentyn Khimchuk on 13.12.2022.
//

import UIKit

class ViewController: UIViewController, AlertPresentableVC {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    var viewModel: AirportListViewModelProtocol?

    private var tableViewAdapter: MainTableViewDataSourceAdapter?
    private var dataSource: [AirportModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        configureTableView()
        setupListeners()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        loadData()
    }

    // MARK: - Private methods
    private func configureTableView() {
        tableViewAdapter = MainTableViewDataSourceAdapter(delegate: self)
        tableViewAdapter?.delegate = self
        tableViewAdapter?.configure(with: tableView)
    }

    private func loadData() {
        viewModel?.loadData()
    }

    private func setupListeners() {
        viewModel?.onError = { [weak self] errorDetails in
            self?.presentAlert(text: "Something went wrong", description: errorDetails.localizedDescription)
        }

        viewModel?.onDataLoaded = { [weak self] data in
            self?.tableViewAdapter?.update(with: data)
            self?.dataSource = data
            self?.tableView.reloadData()
        }
    }

    @IBAction private func showFilter() {
        let alert = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Name", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            self.tableViewAdapter?.update(with: self.dataSource.sorted { $0.name < $1.name })
            self.tableView.reloadData()
        })

        alert.addAction(UIAlertAction(title: "Timezone", style: .default) { [weak self] _ in
            guard let self = self else { return }

            self.tableViewAdapter?.update(with: self.dataSource.sorted { $0.timeZone < $1.timeZone })
            self.tableView.reloadData()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alert, animated: true)
    }
}

// MARK: - MainTableViewDelegate
extension ViewController: MainTableViewDelegate {
    var viewController: ViewController {
        self
    }

    func showDetails(airport: AirportModel) {
        guard let viewModel = viewModel else { return }
        viewModel.onAirportDetails?(airport, viewModel.readingManager, airport.code)
    }
}

// MARK: - StoryboardController
extension ViewController: StoryboardController {
    static var storyboard: Storyboard {
        .Main
    }
}
