//
//  ListTableViewCell.swift
//  MarvelComic
//
//  Created by Test on 06/03/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     
    let thumbnailImg: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Marvel", size: 35)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "Marvel", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Marvel", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Marvel", size: 16)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let comicsLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Marvel", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let seriesLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Marvel", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let eventsLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Marvel", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let storiesLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Marvel", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let modifiedLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Marvel", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let resourceLbl: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let IDLbl: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setImageImg(urlString: String){
        self.thumbnailImg.image = UIImage(named: "loadingImage")
        self.thumbnailImg.load(urlString: urlString)
    }
    
    func setTitleLbl(titleLbl: String){
        self.titleLbl.text = titleLbl
    }
    
    func getTitleLbl() -> String{
        return self.titleLbl.text ?? ""
    }
    
    func setDescriptionLbl(descriptionLbl: String){
        self.descriptionLbl.text = descriptionLbl
    }
    
    func getThumbnailImg() ->String {
        return self.descriptionLbl.text ?? ""
    }
    
    func setPriceLbl(priceLbl: String){
        self.priceLbl.text = "Price: \(priceLbl)"
    }
    
    func getPriceLbl() ->String {
        return self.priceLbl.text ?? ""
    }
    
    func setDateLbl(dateLbl: String){
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:dateLbl) ?? Date()
        
        let stringformatter = DateFormatter()
        stringformatter.dateFormat = "yyyy-MM-dd"
        
        self.dateLbl.text = "FOC: \(stringformatter.string(from: date))"
    }
    
    func getDateLbl() ->String {
        return self.dateLbl.text ?? ""
    }
    
    func setComicsLbl(comicsLbl: String){
        self.comicsLbl.text = "Comics: \(comicsLbl)"
    }
    
    func getComicsLbl() ->String {
        return self.comicsLbl.text ?? ""
    }
    
    func setSeriesLbl(seriesLbl: String){
        self.seriesLbl.text = "Series: \(seriesLbl)"
    }
    
    func getSeriesLbl() ->String {
        return self.seriesLbl.text ?? ""
    }
    
    func setEventsLbl(eventsLbl: String){
        self.eventsLbl.text = "Events: \(eventsLbl)"
    }
    
    func getEventsLbl() ->String {
        return self.eventsLbl.text ?? ""
    }
    
    func setStoriesLbl(storiesLbl: String){
        self.storiesLbl.text = "Stories: \(storiesLbl)"
    }
    
    func getStoriesLbl() ->String {
        return self.storiesLbl.text ?? ""
    }
    
    func setModifiedLbl(modifiedLbl: String){
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: modifiedLbl) {
            let stringformatter = DateFormatter()
            stringformatter.dateFormat = "yyyy-MM-dd"
            
            
            self.modifiedLbl.text = "Modified: \(stringformatter.string(from: date))"
        }
    }
    
    func getModifiedLbl() ->String {
        return self.modifiedLbl.text ?? ""
    }
    
    func setResourceLbl(resourceLbl: String){
        self.resourceLbl.text = resourceLbl
    }
    
    func getResourceLbl() ->String {
        return self.resourceLbl.text ?? ""
    }
    
    func setIDLbl(IDLbl: String){
        self.IDLbl.text = IDLbl
    }
    
    func getIDLbl() ->String {
        return self.IDLbl.text ?? ""
    }
    
    
    
    func createComicCell(){
        
        self.addSubview(thumbnailImg)
        self.addSubview(titleLbl)
        self.addSubview(descriptionLbl)
        self.addSubview(priceLbl)
        self.addSubview(dateLbl)
        self.addSubview(resourceLbl)
        self.addSubview(IDLbl)
        
        thumbnailImg.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        thumbnailImg.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        thumbnailImg.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        thumbnailImg.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        titleLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        titleLbl.leftAnchor.constraint(equalTo: thumbnailImg.rightAnchor, constant: 5).isActive = true
        titleLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        titleLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        descriptionLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 5).isActive = true
        descriptionLbl.leftAnchor.constraint(equalTo: thumbnailImg.rightAnchor, constant: 5).isActive = true
        descriptionLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        descriptionLbl.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        priceLbl.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor, constant: 5).isActive = true
        priceLbl.leftAnchor.constraint(equalTo: thumbnailImg.rightAnchor, constant: 5).isActive = true
        priceLbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        priceLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        dateLbl.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor, constant: 5).isActive = true
        dateLbl.leftAnchor.constraint(equalTo: priceLbl.rightAnchor, constant: 5).isActive = true
        dateLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        dateLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        resourceLbl.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor, constant: 5).isActive = true
        resourceLbl.leftAnchor.constraint(equalTo: thumbnailImg.rightAnchor, constant: 5).isActive = true
        resourceLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        resourceLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        IDLbl.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor, constant: 5).isActive = true
        IDLbl.leftAnchor.constraint(equalTo: thumbnailImg.rightAnchor, constant: 5).isActive = true
        IDLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        IDLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func crateCharacterCell(){
        let width = self.frame.width - 160
        self.addSubview(thumbnailImg)
        self.addSubview(titleLbl)
        self.addSubview(comicsLbl)
        self.addSubview(seriesLbl)
        self.addSubview(eventsLbl)
        self.addSubview(storiesLbl)
        self.addSubview(modifiedLbl)
        self.addSubview(resourceLbl)
        self.addSubview(IDLbl)
        
        thumbnailImg.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        thumbnailImg.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        thumbnailImg.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        thumbnailImg.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        titleLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        titleLbl.leftAnchor.constraint(equalTo: thumbnailImg.rightAnchor, constant: 5).isActive = true
        titleLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        titleLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        comicsLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 5).isActive = true
        comicsLbl.leftAnchor.constraint(equalTo: thumbnailImg.rightAnchor, constant: 5).isActive = true
        comicsLbl.widthAnchor.constraint(equalToConstant: width/2).isActive = true
        comicsLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        seriesLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 5).isActive = true
        seriesLbl.leftAnchor.constraint(equalTo: comicsLbl.rightAnchor, constant: 5).isActive = true
        seriesLbl.widthAnchor.constraint(equalToConstant: width/2).isActive = true
        seriesLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        eventsLbl.topAnchor.constraint(equalTo: comicsLbl.bottomAnchor, constant: 5).isActive = true
        eventsLbl.leftAnchor.constraint(equalTo: thumbnailImg.rightAnchor, constant: 5).isActive = true
        eventsLbl.widthAnchor.constraint(equalToConstant: width/2).isActive = true
        eventsLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        storiesLbl.topAnchor.constraint(equalTo: seriesLbl.bottomAnchor, constant: 5).isActive = true
        storiesLbl.leftAnchor.constraint(equalTo: eventsLbl.rightAnchor, constant: 5).isActive = true
        storiesLbl.widthAnchor.constraint(equalToConstant: width/2).isActive = true
        storiesLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        modifiedLbl.topAnchor.constraint(equalTo: eventsLbl.bottomAnchor, constant: 5).isActive = true
        modifiedLbl.leftAnchor.constraint(equalTo: thumbnailImg.rightAnchor, constant: 5).isActive = true
        modifiedLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        modifiedLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        resourceLbl.topAnchor.constraint(equalTo: modifiedLbl.bottomAnchor, constant: 5).isActive = true
        resourceLbl.leftAnchor.constraint(equalTo: thumbnailImg.rightAnchor, constant: 5).isActive = true
        resourceLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        resourceLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        IDLbl.topAnchor.constraint(equalTo: modifiedLbl.bottomAnchor, constant: 5).isActive = true
        IDLbl.leftAnchor.constraint(equalTo: thumbnailImg.rightAnchor, constant: 5).isActive = true
        IDLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        IDLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
