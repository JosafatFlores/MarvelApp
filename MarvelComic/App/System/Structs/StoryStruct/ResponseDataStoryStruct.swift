//
//  ResponseDataStoryStruct.swift
//  MarvelComic
//
//  Created by Test on 09/03/21.
//

import Foundation
struct ResponseDataStoryStruct: Codable {
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var results: [StoryStruct]
}
