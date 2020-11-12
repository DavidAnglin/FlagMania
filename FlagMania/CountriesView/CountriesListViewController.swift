//
//  CountriesListViewController.swift
//  FlagMania
//
//  Created by David Anglin on 11/12/20.
//

import UIKit

class CountriesListViewController: UIViewController {
    
    // MARK: Properties
    weak var coordinator: AppCoordinator?
    var viewModel: CountriesListViewModelContract!
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel: CountriesListViewModelContract) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.getTitle()
        tableView.tableFooterView = UIView.init(frame: .zero)
        tableView.register(UINib.init(nibName: CountryCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CountryCell.reuseIdentifier)
        
        viewModel.fetchCountries { [weak self] success in
            switch success {
            case true:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case false:
                // Show alert for error
                print("We failed")
            }
        }
    }
}

// MARK: TableView Methods
extension CountriesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.reuseIdentifier, for: indexPath) as? CountryCell else { return UITableViewCell() }
        
        let country = viewModel.countries[indexPath.row]
        cell.configue(with: country)
        return cell
    }
}
