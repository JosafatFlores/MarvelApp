//
//  Encryptor.swift
//  MarvelComic
//
//  Created by Test on 05/03/21.
//

import Foundation
import CryptoKit

class Encryptor: NSObject {
    func encryptorMD5(ts: String) -> String{
        
        let hashString = ts + Sesion.instance.privateKey + Sesion.instance.publicKey
        let md5Json = Insecure.MD5.hash(data: hashString.data(using: .utf8) ?? Data())
        let md5String = md5Json.map { String(format: "%02hhx", $0) }.joined()
        
        return md5String
    }
}
