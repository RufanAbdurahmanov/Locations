//
//  CategoryCollectionViewCell.swift
//  Task3MapKit
//
//  Created by Rufan Abdurahmanov on 25.04.22.
//

import UIKit

protocol CellProtocol {
    var titleName: String { get }
    var imageName: String? { get }
}

extension CellProtocol {
    var imageName: String? {
        ""
    }
}

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
        
    func configure(data: CellProtocol) {
        backgroundColor = .white
        layer.cornerRadius = 9
        dropShadow()
        nameLabel.text = data.titleName
        imageView.image = UIImage(named: data.imageName ?? "")
    }
}
