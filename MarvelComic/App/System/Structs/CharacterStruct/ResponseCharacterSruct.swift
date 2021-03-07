//
//  ResponseCharacterSruct.swift
//  MarvelComic
//
//  Created by Test on 06/03/21.
//

import Foundation
struct ResponseCharacterStruct: Codable {
    var code: Int
    var status: String
    var data: ResponseDataCharacterStruct
}
