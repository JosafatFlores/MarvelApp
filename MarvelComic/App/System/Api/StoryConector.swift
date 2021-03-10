//
//  StoryConector.swift
//  MarvelComic
//
//  Created by Test on 09/03/21.
//

import Foundation
class StoryConector: NSObject {
    func getStoryDetail(resourceURI:String, _ resultData: @escaping ResultStoryData){
        var errorResponse: String = ""
        
        let ts: String = String(Int((Date().timeIntervalSince1970*1000)))

        var apiPath = resourceURI
        apiPath += "?apikey=\(Sesion.instance.publicKey)"
        apiPath += "&ts=\(ts)"
        apiPath += "&hash=\(Encryptor().encryptorMD5(ts: ts))"
        
        var request = URLRequest(url: URL(string: apiPath)!)
        request.httpMethod = "GET"
        
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            
            if let error = err {
                errorResponse = "error"
                resultData(nil, error.localizedDescription)
                print(error)
                return
            }
            let httpResponse = res as! HTTPURLResponse
            if httpResponse.statusCode == 200{
                if let data = data {
                    let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    let dataRecived:Data = (dataString?.data(using: String.Encoding.utf8.rawValue))!
                    
                    do{
                        let responseData = try JSONDecoder().decode(ResponseStoryStruct.self, from: dataRecived)
                        
                        resultData(responseData.data, String(responseData.code))
                    }catch let jsonErr{
                        print(jsonErr)
                        errorResponse = "error"
                        resultData(nil, errorResponse)
                    }
                }
            }else{
                errorResponse = String(httpResponse.statusCode)
                resultData(nil, errorResponse)
            }
            
        }
        task.resume()
    }
}
