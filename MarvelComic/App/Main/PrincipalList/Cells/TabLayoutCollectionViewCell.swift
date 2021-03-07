//
//  TabLayoutCollectionViewCell.swift
//  MarvelComic
//
//  Created by Test on 06/03/21.
//

import UIKit

class TabLayoutCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let title: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let index: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.isHidden = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func createCell(){
        self.addSubview(title)
        self.addSubview(index)
        
        title.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        index.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        index.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        index.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        index.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
