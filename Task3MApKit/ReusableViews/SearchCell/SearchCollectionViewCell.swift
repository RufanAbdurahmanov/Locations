//
//  SearchCollectionViewCell.swift
//  Task3MapKit
//
//  Created by Rufan Abdurahmanov on 27.04.22.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(data: CellProtocol) {
        backgroundColor = UIColor(displayP3Red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        nameLabel.text = data.titleName
//        nameLabel.layer.shadowColor = UIColor.black.cgColor
//        nameLabel.layer.shadowOpacity = 1
//        nameLabel.layer.shadowOffset = .zero
//        nameLabel.layer.shadowRadius = 30

    }

}
