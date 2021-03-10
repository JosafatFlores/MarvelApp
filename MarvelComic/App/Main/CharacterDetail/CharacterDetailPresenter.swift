//
//  CharacterDetailPresenter.swift
//  MarvelComic
//
//  Created by Test on 09/03/21.
//

import Foundation
class CharacterDetailPresenter: NSObject {
    weak private var characterDetailView: CharacterDetailViewController?
    
    private let comicService: ComicConector?
    private let characterService: CharacterConector
    private let storyService: StoryConector?
    
    init(comicServ: ComicConector, characterServ: CharacterConector, storyServ: StoryConector){
        comicService = comicServ
        characterService = characterServ
        storyService = storyServ
    }
    
    func attachView(view: CharacterDetailViewController){
        characterDetailView = view
    }
    
    func getChatracterDetail(resourceURI: String){
        self.characterDetailView?.showedSpinner()
        characterService.getCharacterDetail(resourceURI: resourceURI){ (data, message)  in
            self.characterDetailView?.removedSpinner()
            if message == "200"{
                self.characterDetailView?.setData(data: data!)
                
            }else{
                self.characterDetailView?.error(title: "Comics", message: "Can't connect with Stark tower \nCode: \(message)")
            }
        }
    }
    
    func getComics(resourceURI: String){
        comicService?.getComicDetail(resourceURI: resourceURI){ (data, message)  in
            if message == "200"{
                self.characterDetailView?.setComicsData(data: data!)
            }else{
                self.characterDetailView?.error(title: "Comics", message: "Can't connect with Stark tower \nCode: \(message)")
            }
        }
    }
    
    func getStories(resourceURI: String){
        storyService?.getStoryDetail(resourceURI: resourceURI){ (data, message)  in
            if message == "200"{
                self.characterDetailView?.setStoriesData(data: data!)
            }else{
                self.characterDetailView?.error(title: "Comics", message: "Can't connect with Stark tower \nCode: \(message)")
            }
        }
    }
}
