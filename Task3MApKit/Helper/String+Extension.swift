//
//  String+Extension.swift
//  Task3MapKit
//
//  Created by Rufan Abdurahmanov on 27.04.22.
//

import Foundation

extension String {
    func replace() -> String {
        return replacingOccurrences(of: " ", with: "_")
    }
}

