//
//  ResponseDataComicStruct.swift
//  MarvelComic
//
//  Created by Test on 05/03/21.
//

import Foundation
struct ResponseDataComicStruct: Codable {
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var results: [ComicStruct]?
}
