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
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
        
    func configue(with country: Country) {
        countryLabel.text = country.name
        capitalLabel.text = country.capital
        
        DispatchQueue.global(qos: .background).async {
            if let flagImageUrl = URL(string: country.flagURL),
                let imageData = try? Data(contentsOf: flagImageUrl) {
                DispatchQueue.main.async {
                    self.flagImageView.image = UIImage(data: imageData)
                }
            } else {
                DispatchQueue.main.async {
                    self.flagImageView.image = nil
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        flagImageView.image = nil
        countryLabel.text = nil
        capitalLabel.text = nil
    }
}
