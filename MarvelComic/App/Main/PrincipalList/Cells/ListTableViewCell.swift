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
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Marvel", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Marvel", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Marvel", size: 16)
        label.textAlignment = .right
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
        self.priceLbl.text = priceLbl
    }
    
    func getPriceLbl() ->String {
        return self.priceLbl.text ?? ""
    }
    
    func setDateLbl(dateLbl: String){
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:dateLbl) ?? Date()
        
        let stringformatter = DateFormatter()
        stringformatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        self.dateLbl.text = stringformatter.string(from: date)
    }
    
    func getDateLbl() ->String {
        return self.dateLbl.text ?? ""
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
    
    func createCell(){
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
        priceLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        priceLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        dateLbl.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor, constant: 5).isActive = true
        dateLbl.leftAnchor.constraint(equalTo: thumbnailImg.rightAnchor, constant: 5).isActive = true
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
}
