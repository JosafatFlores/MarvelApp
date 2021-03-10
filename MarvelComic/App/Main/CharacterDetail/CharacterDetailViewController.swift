//
//  CharacterDetailViewController.swift
//  MarvelComic
//
//  Created by Test on 09/03/21.
//

import UIKit

class CharacterDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    private var characterDetailPresenter: CharacterDetailPresenter = CharacterDetailPresenter(comicServ: ComicConector(), characterServ: CharacterConector(), storyServ: StoryConector())
    
    let nf = "Not found"
    
    var resourceURI: String = ""
    
    var characterData: CharacterStruct = CharacterStruct()
    
    var comicsData: [ComicStruct] = []
    var storiesData: [StoryStruct] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createView()
        
        characterDetailPresenter.attachView(view: self)
        characterDetailPresenter.getChatracterDetail(resourceURI: resourceURI)
        
        comicsCll.delegate = self
        comicsCll.dataSource = self
        comicsCll.register(GaleryItemCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        
        storiesTbl.delegate = self
        storiesTbl.dataSource = self
        storiesTbl.layer.backgroundColor = UIColor.clear.cgColor
        storiesTbl.backgroundColor = .black
        storiesTbl.register(ListTableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func setData(data: ResponseDataCharacterStruct){
        characterData = data.results[0]
        
        characterDetailPresenter.getComics(resourceURI: characterData.comics?.collectionURI ?? "")
        characterDetailPresenter.getStories(resourceURI: characterData.stories?.collectionURI ?? "")
        DispatchQueue.main.async {
            self.titleLbl.text = self.characterData.name
            self.IDLbl.text! += String(self.characterData.id ?? 0)
            self.modifiedLbl.text! += Formatter().dateReduceFormatter(date: self.characterData.modified!)
            self.descriptionLbl.text = self.characterData.description ?? self.nf
            
            let fullPathImage = "\(self.characterData.thumbnail?.path ?? "").\(self.characterData.thumbnail?.extension ?? "")"
            
            self.coverImg.load(urlString: fullPathImage)
        }
    }
    
    func setComicsData(data: ResponseDataComicStruct){
        comicsData = data.results
        DispatchQueue.main.async {
            self.comicsCll.reloadData()
        }
    }
    
    func setStoriesData(data: ResponseDataStoryStruct){
        storiesData = data.results
        DispatchQueue.main.async {
            self.storiesTbl.reloadData()
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
    
    private let modifiedLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Modified: "
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
    
    private let coverImg: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loadingImage")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let comicsLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Comics"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let comicsCll: UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.itemSize = .init(width: 150, height: 200)
        
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0.0;
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(named: "black_0_0_0")
        
        collection.bounces = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private let storiesLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Stories"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let storiesTbl: UITableView = {
        let table = UITableView()
        table.allowsSelection = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
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
        scrollView.addSubview(modifiedLbl)
        scrollView.addSubview(descriptionLbl)
        scrollView.addSubview(coverImg)
        scrollView.addSubview(comicsLbl)
        scrollView.addSubview(comicsCll)
        scrollView.addSubview(storiesLbl)
        scrollView.addSubview(storiesTbl)
        
        coverImg.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: topMargin*2).isActive = true
        coverImg.leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralMargin).isActive = true
        coverImg.rightAnchor.constraint(equalTo: view.rightAnchor, constant: lateralMargin).isActive = true
        coverImg.heightAnchor.constraint(equalToConstant: heightLbl*10).isActive = true
        coverImg.centerXAnchor.constraint(equalTo: coverImg.centerXAnchor).isActive = true
        
        titleLbl.topAnchor.constraint(equalTo: coverImg.bottomAnchor, constant: 10).isActive = true
        titleLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralMargin).isActive = true
        titleLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -lateralMargin).isActive = true
        titleLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        IDLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: topMargin).isActive = true
        IDLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralMargin).isActive = true
        IDLbl.widthAnchor.constraint(equalToConstant: width/2).isActive = true
        IDLbl.heightAnchor.constraint(equalToConstant: heightLbl).isActive = true
        
        modifiedLbl.topAnchor.constraint(equalTo: IDLbl.bottomAnchor, constant: topMargin).isActive = true
        modifiedLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralMargin).isActive = true
        modifiedLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: lateralMargin).isActive = true
        modifiedLbl.heightAnchor.constraint(equalToConstant: heightLbl).isActive = true
        
        descriptionLbl.topAnchor.constraint(equalTo: modifiedLbl.bottomAnchor, constant: topMargin).isActive = true
        descriptionLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralMargin).isActive = true
        descriptionLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: lateralMargin).isActive = true
        descriptionLbl.heightAnchor.constraint(equalToConstant: heightLbl*10).isActive = true
        
        comicsLbl.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor, constant: topMargin*4).isActive = true
        comicsLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralMargin).isActive = true
        comicsLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: lateralMargin).isActive = true
        comicsLbl.heightAnchor.constraint(equalToConstant: heightLbl).isActive = true
        
        comicsCll.topAnchor.constraint(equalTo: comicsLbl.bottomAnchor, constant: topMargin).isActive = true
        comicsCll.leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralMargin).isActive = true
        comicsCll.rightAnchor.constraint(equalTo: view.rightAnchor, constant: lateralMargin).isActive = true
        comicsCll.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        storiesLbl.topAnchor.constraint(equalTo: comicsCll.bottomAnchor, constant: topMargin*4).isActive = true
        storiesLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralMargin).isActive = true
        storiesLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: lateralMargin).isActive = true
        storiesLbl.heightAnchor.constraint(equalToConstant: heightLbl).isActive = true
        
        storiesTbl.topAnchor.constraint(equalTo: storiesLbl.bottomAnchor, constant: topMargin).isActive = true
        storiesTbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralMargin).isActive = true
        storiesTbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: lateralMargin).isActive = true
        storiesTbl.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 1100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var rows = 0
        rows = comicsData.count
        
        return rows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCellItem: GaleryItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! GaleryItemCollectionViewCell
        
        collectionCellItem.setThumbnailImg(urlString: "\(comicsData[indexPath.row].thumbnail?.path ?? "").\(comicsData[indexPath.row].thumbnail?.extension ?? "")")
        collectionCellItem.setTitleLbl(titleLbl: comicsData[indexPath.row].title ?? nf)
        collectionCellItem.createCell()
        
        
        return collectionCellItem
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        
        rows = storiesData.count
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        
        cell.setTitleLbl(titleLbl: storiesData[indexPath.row].title)
        cell.backgroundColor = .clear
        cell.createStoryCell()
        
        return cell
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
