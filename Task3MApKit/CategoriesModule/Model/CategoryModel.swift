//
//  CategoryModel.swift
//  Task3MapKit
//
//  Created by Rufan Abdurahmanov on 26.04.22.
//

import Foundation
import UIKit

struct CategoryModel: CellProtocol {
    let title: String
    let image: String
    
    var titleName: String {
        title
    }
    
    var imageName: String? {
        image
    }
}
