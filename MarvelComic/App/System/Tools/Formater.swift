//
//  Formater.swift
//  MarvelComic
//
//  Created by Test on 09/03/21.
//

import Foundation
class Formatter: NSCoder {
    func dateFormatter(date: String) -> String{
        var dateFormatted: String = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: date) {
            let stringformatter = DateFormatter()
            stringformatter.dateFormat = "yyyy-MM-dd"
            
            
            dateFormatted = stringformatter.string(from: date)
        }
        return dateFormatted
    }
    
    func dateReduceFormatter(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: date) ?? Date()
        
        let stringformatter = DateFormatter()
        stringformatter.dateFormat = "yyyy-MM-dd"
        
        return stringformatter.string(from: date)
    }
}
