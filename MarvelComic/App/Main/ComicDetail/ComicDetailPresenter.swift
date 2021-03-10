//
//  ComicDetailPresenter.swift
//  MarvelComic
//
//  Created by Test on 08/03/21.
//

import Foundation
class ComicDetailPresenter: NSObject {
    weak private var comicDetailView: ComicDetailViewController?
    
    private let comicService: ComicConector?
    private let characterService: CharacterConector
    private let storyService: StoryConector?
    
    init(comicServ: ComicConector, characterServ: CharacterConector, storyServ: StoryConector){
        comicService = comicServ
        characterService = characterServ
        storyService = storyServ
    }
    
    func attachView(view: ComicDetailViewController){
        comicDetailView = view
    }
    
    func getComicDetail(resourceURI: String){
        self.comicDetailView?.showedSpinner()
        comicService?.getComicDetail(resourceURI: resourceURI){ (data, message)  in
            self.comicDetailView?.removedSpinner()
            if message == "200"{
                self.comicDetailView?.setData(data: data!)
                
            }else{
                self.comicDetailView?.error(title: "Comics", message: "Can't connect with Stark tower \nCode: \(message)")
            }
        }
    }
    
    func getCharacters(resourceURI: String){
        
        characterService.getCharacterDetail(resourceURI: resourceURI){ (data, message)  in
            if message == "200"{
                self.comicDetailView?.setCharactersData(data: data!)
            }else{
                self.comicDetailView?.error(title: "Comics", message: "Can't connect with Stark tower \nCode: \(message)")
            }
        }
    }
    
    func getStories(resourceURI: String){
        
        storyService?.getStoryDetail(resourceURI: resourceURI){ (data, message)  in
            if message == "200"{
                self.comicDetailView?.setStoriesData(data: data!)
            }else{
                self.comicDetailView?.error(title: "Comics", message: "Can't connect with Stark tower \nCode: \(message)")
            }
        }
    }
}
