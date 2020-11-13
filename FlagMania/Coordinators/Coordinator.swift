//
//  Coordinator.swift
//  FlagMania
//
//  Created by David Anglin on 11/12/20.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
