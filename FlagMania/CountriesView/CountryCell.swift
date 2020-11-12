//
//  CountryCell.swift
//  FlagMania
//
//  Created by David Anglin on 11/12/20.
//

import UIKit

class CountryCell: UITableViewCell {
    static var reuseIdentifier: String {
        return "CountryCell"
    }
    
    // MARK: IBOutlets
    @IBOutlet weak var flagImageView: CachedImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
        
    func configure(with country: Country) {
        countryLabel.text = country.name
        capitalLabel.text = country.capital
        self.flagImageView.loadImage(with: country.flagURL)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        flagImageView.image = nil
        countryLabel.text = nil
        capitalLabel.text = nil
    }
}
