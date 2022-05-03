//
//  ListCollectionViewCell.swift
//  Task3MapKit
//
//  Created by Rufan Abdurahmanov on 26.04.22.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(data: CellProtocol) {
        backgroundColor = .white
        layer.cornerRadius = 7
        dropShadow()
        nameLabel.text = data.titleName
    }
}
