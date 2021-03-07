//
//  Sesion.swift
//  MarvelComic
//
//  Created by Test on 05/03/21.
//

import Foundation
import UIKit
class Sesion : NSObject {
    
    static let sesion: Sesion = Sesion()
    
    let apiURL: String = "https://gateway.marvel.com:443/v1/public"
    
    let privateKey: String = "83a9affb567ec1f63b6a85f6e2e77a9134524116"
    let publicKey: String  = "6292e36908d1ce6539ff43261f56e1d9"
    
    var offsetComics: Int = 0
    var offsetCharacters: Int = 0
    
    var typeDevice: String = ""
    var navigationBarSize: CGFloat = 0
    
    var topPading:CGFloat = 0
    var bottomPadding:CGFloat = 0
    

    
    class var instance: Sesion {
        return sesion
    }
}
