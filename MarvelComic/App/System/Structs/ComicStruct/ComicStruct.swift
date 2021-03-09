//
//  ComicStruct.swift
//  MarvelComic
//
//  Created by Test on 05/03/21.
//

import Foundation
struct ComicStruct: Codable {
    var id: Int?
    var title: String?
    var issueNumber: Int?
    var format: String?
    var modified: String?
    var prices: [PriceStruct]?
    var description: String?
    var dates: [DateStruct]?
    var thumbnail: ImageStruct?
    var resourceURI: String?
    var characters: CharactersStruct?
}
