//
//  EventStruct.swift
//  MarvelComic
//
//  Created by Test on 07/03/21.
//

import Foundation
struct EventStruct:Codable {
    var available: Int?
    var collectionURI: String?
    var items: [ItemStruct]?
    var returned:Int?
}
