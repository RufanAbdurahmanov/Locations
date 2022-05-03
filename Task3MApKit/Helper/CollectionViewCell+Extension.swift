//
//  CollectionViewCell+Extension.swift
//  Task3MapKit
//
//  Created by Rufan Abdurahmanov on 01.05.22.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    func dropShadow() {
        layer.shadowColor = UIColor(red: 0.64, green: 0.71, blue: 0.78, alpha: 1.00).cgColor
        //layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.masksToBounds = false
      }
}
