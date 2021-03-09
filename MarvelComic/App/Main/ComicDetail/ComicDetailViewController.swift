//
//  ComicDetailViewController.swift
//  MarvelComic
//
//  Created by Test on 08/03/21.
//

import UIKit

class ComicDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var comicDetailPresenter: ComicDetailPresenter = ComicDetailPresenter(comicServ: ComicConector(), characterServ: CharacterConector())
    
    let nf = "Not found"
    
    var resourceURI: String = ""
    
    var comicData: ComicStruct = ComicStruct()
    
    var charactersData: [CharacterStruct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createView()
        
        comicDetailPresenter.attachView(view: self)
        comicDetailPresenter.getComicDetail(resourceURI: resourceURI)
        
        charactersCll.delegate = self
        charactersCll.dataSource = self
        charactersCll.register(GaleryItemCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        
        storiesCll.delegate = self
        storiesCll.dataSource = self
        storiesCll.register(GaleryItemCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        
    }
    
    func setData(data: ResponseDataComicStruct){
        comicData = data.results[0]
        
        comicDetailPresenter.getCharacters(resourceURI: comicData.characters?.collectionURI ?? "")
        DispatchQueue.main.async {
            self.titleLbl.text = self.comicData.title
            self.IDLbl.text! += String(self.comicData.id ?? 0)
            self.issueNumberLbl.text! +=  String(self.comicData.issueNumber ?? 0)
            self.formatLbl.text! += self.comicData.format ?? self.nf
            self.modifiedLbl.text! += Formatter().dateReduceFormatter(date: self.comicData.modified!)
            self.descriptionLbl.text = self.comicData.description ?? self.nf
            
            let fullPathImage = "\(self.comicData.thumbnail?.path ?? "").\(self.comicData.thumbnail?.extension ?? "")"
            
            self.coverImg.load(urlString: fullPathImage)
            for price in self.comicData.prices ?? []{
                let p: PriceStruct = price
                
                if p.type == "printPrice"{
                    self.printPriceLbl.text! += "$\(String(p.price ?? 0))"
                }
                
            }
            
            for date in self.comicData.dates ?? []{
                let d: DateStruct = date
                if d.type == "focDate"{
                    self.focDate.text! += Formatter().dateReduceFormatter(date: d.date!)
                }
                if d.type == "onsaleDate"{
                    self.onSaleDate.text! += Formatter().dateFormatter(date: d.date!)
                }
            }
        }
    }
    
    func setCharactersData(data: ResponseDataCharacterStruct){
        charactersData = data.results
        DispatchQueue.main.async {
            self.charactersCll.reloadData()
        }
    }
    
    @objc func back(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    private let topView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "red_226_54_54")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setImage(UIImage(named: "backIcon"), for: .normal)
        button.layer.cornerRadius = 22
        button.addTarget(self, action:#selector(back(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let IDLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "ID: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let issueNumberLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Issue Number: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let formatLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Format: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let modifiedLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Modified: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let printPriceLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Print Price: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines  = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let onSaleDate: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "On sale date: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let focDate: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "FOC Date: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let coverImg: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loadingImage")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let charactersCll: UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.itemSize = .init(width: 150, height: 200)
        
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(named: "black_0_0_0")
        
        collection.bounces = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private let storiesCll: UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.itemSize = .init(width: 150, height: 200)
        
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(named: "black_0_0_0")
        
        collection.bounces = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    func createView(){
        
        let lateralMargin:CGFloat = CGFloat(5)
        let topMargin:CGFloat = CGFloat(5)
        let heightLbl:CGFloat = CGFloat(20)
        let width = self.view.frame.width
        
        view.addSubview(topView)
        view.addSubview(scrollView)
        
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Sesion.instance.topPading).isActive = true
        
        topView.addSubview(backBtn)
        
        backBtn.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 10).isActive = true
        backBtn.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -5).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(titleLbl)
        scrollView.addSubview(IDLbl)
        scrollView.addSubview(issueNumberLbl)
        scrollView.addSubview(formatLbl)
        scrollView.addSubview(modifiedLbl)
        scrollView.addSubview(printPriceLbl)
        scrollView.addSubview(descriptionLbl)
        scrollView.addSubview(onSaleDate)
        scrollView.addSubview(focDate)
        scrollView.addSubview(coverImg)
        scrollView.addSubview(charactersCll)
        
        coverImg.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: topMargin*2).isActive = true
        coverImg.leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralMargin).isActive = true
        coverImg.rightAnchor.constraint(equalTo: view.rightAnchor, constant: lateralMargin).isActive = true
        coverImg.heightAnchor.constraint(equalToConstant: heightLbl*10).isActive = true
        coverImg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        titleLbl.topAnchor.constraint(equalTo: coverImg.bottomAnchor, constant: 10).isActive = true
        titleLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralMargin).isActive = true
        titleLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -lateralMargin).isActive = true
        titleLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        IDLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: topMargin).isActive = true
        IDLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralMargin).isActive = true
        IDLbl.widthAnchor.constraint(equalToConstant: width/2).isActive = true
        IDLbl.heightAnchor.constraint(equalToConstant: heightLbl).isActive = true
        
        issueNumberLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: topMargin).isActive = true
        issueNumberLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: lateralMargin).isActive = true
        issueNumberLbl.widthAnchor.constraint(equalToConstant: width/2).isActive = true
        issueNumberLbl.heightAnchor.constraint(equalToConstant: heightLbl).isActive = true
        
        formatLbl.topAnchor.constraint(equalTo: issueNumberLbl.bottomAnchor, constant: topMargin).isActive = true
        formatLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralMargin).isActive = true
        formatLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: lateralMargin).isActive = true
        formatLbl.heightAnchor.constraint(equalToConstant: heightLbl).isActive = true
        
        modifiedLbl.topAnchor.constraint(equalTo: formatLbl.bottomAnchor, constant: topMargin).isActive = true
        modifiedLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralMargin).isActive = true
        modifiedLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: lateralMargin).isActive = true
        modifiedLbl.heightAnchor.constraint(equalToConstant: heightLbl).isActive = true
        
        printPriceLbl.topAnchor.constraint(equalTo: modifiedLbl.bottomAnchor, constant: topMargin).isActive = true
        printPriceLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralMargin).isActive = true
        printPriceLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: lateralMargin).isActive = true
        printPriceLbl.heightAnchor.constraint(equalToConstant: heightLbl).isActive = true
        
        descriptionLbl.topAnchor.constraint(equalTo: printPriceLbl.bottomAnchor, constant: topMargin).isActive = true
        descriptionLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralMargin).isActive = true
        descriptionLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: lateralMargin).isActive = true
        descriptionLbl.heightAnchor.constraint(equalToConstant: heightLbl*10).isActive = true
        
        onSaleDate.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor, constant: topMargin).isActive = true
        onSaleDate.leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralMargin).isActive = true
        onSaleDate.rightAnchor.constraint(equalTo: view.rightAnchor, constant: lateralMargin).isActive = true
        onSaleDate.heightAnchor.constraint(equalToConstant: heightLbl).isActive = true
        
        focDate.topAnchor.constraint(equalTo: onSaleDate.bottomAnchor, constant: topMargin).isActive = true
        focDate.leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralMargin).isActive = true
        focDate.rightAnchor.constraint(equalTo: view.rightAnchor, constant: lateralMargin).isActive = true
        focDate.heightAnchor.constraint(equalToConstant: heightLbl).isActive = true
        
        charactersCll.topAnchor.constraint(equalTo: focDate.bottomAnchor, constant: topMargin*2).isActive = true
        charactersCll.leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralMargin).isActive = true
        charactersCll.rightAnchor.constraint(equalTo: view.rightAnchor, constant: lateralMargin).isActive = true
        charactersCll.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 1000)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var rows = 0
        if collectionView == charactersCll{
            rows = charactersData.count
        }else if collectionView == storiesCll{
           
        }
        return rows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCellItem: GaleryItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! GaleryItemCollectionViewCell
        if collectionView == charactersCll{
            collectionCellItem.setThumbnailImg(urlString: "\(charactersData[indexPath.row].thumbnail?.path ?? "").\(charactersData[indexPath.row].thumbnail?.extension ?? "")")
            collectionCellItem.setTitleLbl(titleLbl: charactersData[indexPath.row].name ?? nf)
            collectionCellItem.createCell()
        }else if collectionView == storiesCll{
           
        }
        
        
        return collectionCellItem
    }
    
    
    
    func error(title: String, message: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showedSpinner(){
        self.showSpinner(onView: self.view)
    }
    
    func removedSpinner() {
        self.removeSpinner()
    }
}
