//
//  ComicsStruct.swift
//  MarvelComic
//
//  Created by Test on 06/03/21.
//

import Foundation
struct ComicsStruct: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [ItemStruct]?
    var returned:Int?
}
