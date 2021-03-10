//
//  ResponseStoryStruct.swift
//  MarvelComic
//
//  Created by Test on 09/03/21.
//

import Foundation
struct ResponseStoryStruct: Codable {
    var code: Int
    var status: String
    var data: ResponseDataStoryStruct
}
