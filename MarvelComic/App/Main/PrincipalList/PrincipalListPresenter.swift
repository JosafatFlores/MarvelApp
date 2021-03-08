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
    private let characterService: CharacterConector?

    init(comicServ: ComicConector, charaterServ: CharacterConector){
        comicService = comicServ
        characterService = charaterServ
    }
    
    func attachView(view: PrincipalListViewController){
        principalListView = view
    }
    
    func getComics(offset: String){
        self.principalListView?.showedSpinner()
        comicService?.getComics(offset: offset){ (data, message)  in
            self.principalListView?.removedSpinner()
            if message == "200"{
                self.principalListView?.reloadTableComic(data: data!)
            }else{
                self.principalListView?.error(title: "Comics", message: "Can't connect with Stark tower \nCode: \(message)")
            }
        }
    }
    
    func getCharacters(offset: String){
        characterService?.getCharacters(offset: offset){ (data, message)  in
            if message == "200"{
                self.principalListView?.reloadTableCharacter(data: data!)
            }else{
                self.principalListView?.error(title: "Characters", message: "Can't connect with Stark tower \nCode: \(message)")
            }
        }
    }
}
