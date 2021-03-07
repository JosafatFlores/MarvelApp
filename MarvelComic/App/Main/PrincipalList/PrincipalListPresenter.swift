//
//  PrincipalListPresenter.swift
//  MarvelComic
//
//  Created by Test on 05/03/21.
//

import Foundation
class PrincipalListPresenter: NSObject {
    weak private var principalListView: PrincipalListViewController?
    private let comicService: ComicConector?
    
    init(service: ComicConector){
        comicService = service
        
    }
    
    func attachView(view: PrincipalListViewController){
        principalListView = view
    }
    
    func getComics(){
        self.principalListView?.showedSpinner()
        comicService?.getComics{ (data, message)  in
            self.principalListView?.removedSpinner()
            if message == "200"{
                self.principalListView?.reloadTable(data: data!)
            }else{
                self.principalListView?.error(title: "Comics", message: "Can't connect with Stark tower \nCode: \(message)")
            }
        }
    }
}
