//
//  CharacterStruct.swift
//  MarvelComic
//
//  Created by Test on 06/03/21.
//

import Foundation
struct CharacterStruct: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var modified: String?
    var resourceURI: String?
    var urls: [urlsStruct]?
    var thumbnail: ImageStruct?
    var comics: ComicsStruct?
    var series: SerieStruct?
    var stories: StorieStruct?
    var events: EventStruct?
}

