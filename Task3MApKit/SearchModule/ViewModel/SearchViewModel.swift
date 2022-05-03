//
//  SearchViewModel.swift
//  Task3MapKit
//
//  Created by Rufan Abdurahmanov on 27.04.22.
//

import Foundation

class SearchViewModel {
    
    var items = [SearchModel]()
    var query = ""
    
    func getSearchItems(query: String, complete: @escaping()->()) {
        WebServices.shared.getSearchItems(query: query) { [unowned self] items in
            self.items.removeAll()
            self.items = items
            complete()
        }
    }
    
    
    func numberOfCells() -> Int {
        return items.count
    }
    
    func itemsAtCell(index: Int) -> SearchModel{
        return items[index]
    }
    
}
