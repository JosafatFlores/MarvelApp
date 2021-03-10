//
//  FilterStruct.swift
//  MarvelComic
//
//  Created by Test on 10/03/21.
//

import Foundation
struct FilterStruct {
    var filterID: String?
    var description: String?
}

class Filter: NSObject {
    func filterComic() -> [FilterStruct]{
        var filters: [FilterStruct] = []
        
        filters.append(FilterStruct(filterID: "", description: "None"))
        filters.append(FilterStruct(filterID: "title", description: "Title"))
        filters.append(FilterStruct(filterID: "titleStartsWith", description: "Title starts with"))
        filters.append(FilterStruct(filterID: "issueNumber", description: "Issue number"))
        
        return filters
    }
    
    func filterCharacter() -> [FilterStruct]{
        var filters: [FilterStruct] = []
        
        filters.append(FilterStruct(filterID: "", description: "None"))
        filters.append(FilterStruct(filterID: "name", description: "Name"))
        filters.append(FilterStruct(filterID: "nameStartsWith", description: "Name starts with"))
        filters.append(FilterStruct(filterID: "comics", description: "Comics"))
        filters.append(FilterStruct(filterID: "stories", description: "Stories"))
        
        return filters
    }
}
