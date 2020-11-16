//
//  CountryDetailViewController.swift
//  FlagMania
//
//  Created by David Anglin on 11/16/20.
//

import UIKit

class CountryDetailViewController: UIViewController {
    
    // MARK: Properties
    weak var coordinator: AppCoordinator?
    var viewModel: CountryDetailVMContract!
    
    // MARK: IBOutlets
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var timezoneLabel: UILabel!
    
    init(viewModel: CountryDetailVMContract) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.getCountryName()
        capitalLabel.text = viewModel.getCapital()
        populationLabel.text = viewModel.getPopulation()
        
        setTimezoneLabel()
    }
    
    func setTimezoneLabel() {
        var timezoneString = String()
        for timezone in viewModel.getTimezones() {
            timezoneString.append(timezone)
            timezoneString.append(", ")
        }
        
        timezoneLabel.text = timezoneString
    }
}
