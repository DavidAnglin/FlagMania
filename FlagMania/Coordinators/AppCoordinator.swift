//
//  AppCoordinator.swift
//  FlagMania
//
//  Created by David Anglin on 11/12/20.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = CountriesListViewModel(apiClient: CountriesService(apiClient: APIClient()))
        let countriesVC = CountriesListViewController(viewModel: viewModel)
        countriesVC.coordinator = self
        navigationController.pushViewController(countriesVC, animated: true)
    }
}
