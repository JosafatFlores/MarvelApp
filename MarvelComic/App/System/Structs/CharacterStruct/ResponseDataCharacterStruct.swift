//
//  ResponseDataCharacterStruct.swift
//  MarvelComic
//
//  Created by Test on 06/03/21.
//

import Foundation
struct ResponseDataCharacterStruct: Codable {
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var results: [CharacterStruct]
    
}
