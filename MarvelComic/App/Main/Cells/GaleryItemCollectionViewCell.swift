//
//  GaleryItemCollectionViewCell.swift
//  MarvelComic
//
//  Created by Test on 09/03/21.
//

import UIKit

class GaleryItemCollectionViewCell: UICollectionViewCell {
    
    private let thumbnailImg: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loadingImage")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    private let titleLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setThumbnailImg(urlString: String){
        self.thumbnailImg.load(urlString: urlString)
    }
    
    func setTitleLbl(titleLbl: String){
        self.titleLbl.text = titleLbl
    }
    
    func createCell(){
        self.addSubview(thumbnailImg)
        self.addSubview(titleLbl)
        
        thumbnailImg.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        thumbnailImg.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        thumbnailImg.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        thumbnailImg.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        titleLbl.topAnchor.constraint(equalTo: thumbnailImg.bottomAnchor).isActive = true
        titleLbl.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        titleLbl.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
}
