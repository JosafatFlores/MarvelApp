//
//  PrincipalListViewController.swift
//  MarvelComic
//
//  Created by Test on 05/03/21.
//

import UIKit

class PrincipalListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    private var principalListPresenter: PrincipalListPresenter = PrincipalListPresenter(comicServ: ComicConector(), charaterServ: CharacterConector())
    
    let nf = "Not found"
    
    var menu: Array = [String]()
    var collectionCellSelected = 0
    
    var comicData: [ComicStruct] = []
    var characterData: [CharacterStruct] = []
    
    var comicsOffset = 0
    var characterOffset = 0
    
    var comicsLimit = 0
    var charactersLimit = 0
    
    var comicsTotal = 0
    var charactersTotal = 0
    
    var resourceURISelected: String = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu.append("Comics")
        menu.append("Characters")
        
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "red_226_54_54")
        
        tabLayout.delegate = self
        tabLayout.dataSource = self
        tabLayout.register(TabLayoutCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        
        comicsTbl.delegate = self
        comicsTbl.dataSource = self
        comicsTbl.layer.backgroundColor = UIColor.clear.cgColor
        comicsTbl.backgroundColor = .black
        comicsTbl.register(ListTableViewCell.self, forCellReuseIdentifier: "cell")
        
        charactersTbl.delegate = self
        charactersTbl.dataSource = self
        charactersTbl.layer.backgroundColor = UIColor.clear.cgColor
        charactersTbl.backgroundColor = .black
        charactersTbl.register(ListTableViewCell.self, forCellReuseIdentifier: "cell")
        
        createView()
        
        principalListPresenter.attachView(view: self)
        principalListPresenter.getComics(offset: String(comicsOffset))
        principalListPresenter.getCharacters(offset: String(characterOffset))
    }
    
    func reloadTableComic(data: ResponseDataComicStruct){
        comicData = data.results
        comicsLimit = data.limit
        comicsTotal =  data.total
        DispatchQueue.main.async {
            self.enabledButtons()
            self.comicsTbl.reloadData()
        }
    }
    
    func reloadTableCharacter(data: ResponseDataCharacterStruct){
        characterData = data.results
        charactersLimit = data.limit
        charactersTotal =  data.total
        DispatchQueue.main.async {
            self.charactersTbl.reloadData()
        }
    }
    
    private let topView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "red_226_54_54")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tabLayout: UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.itemSize = .init(width: 150, height: 45)
        
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(named: "black_0_0_0")
        
        collection.bounces = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private let comicsTbl: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let charactersTbl: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let bottonView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "red_226_54_54")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let reduceOffset:UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitleColor( .white, for: .normal)
        button.setTitle("< 20", for: .normal)
        button.layer.cornerRadius = 7
        button.addTarget(self, action:#selector(reduceOffset(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let addOffset:UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitleColor( .white, for: .normal)
        button.setTitle("20 >", for: .normal)
        button.layer.cornerRadius = 7
        button.addTarget(self, action:#selector(addOffset(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let counterLbl: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func createView(){
        view.addSubview(tabLayout)
        view.addSubview(comicsTbl)
        view.addSubview(charactersTbl)
        view.addSubview(bottonView)
        view.addSubview(topView)
        
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Sesion.instance.topPading).isActive = true
        
        tabLayout.topAnchor.constraint(equalTo: view.topAnchor, constant: Sesion.instance.topPading).isActive = true
        tabLayout.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tabLayout.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tabLayout.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        comicsTbl.topAnchor.constraint(equalTo: tabLayout.bottomAnchor).isActive = true
        comicsTbl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        comicsTbl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        comicsTbl.bottomAnchor.constraint(equalTo: bottonView.topAnchor).isActive = true

        charactersTbl.topAnchor.constraint(equalTo: tabLayout.bottomAnchor).isActive = true
        charactersTbl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        charactersTbl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        charactersTbl.bottomAnchor.constraint(equalTo: bottonView.topAnchor).isActive = true
        charactersTbl.isHidden = true
        
        bottonView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottonView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottonView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottonView.heightAnchor.constraint(equalToConstant: Sesion.instance.bottomPadding + 55).isActive = true
        bottonView.backgroundColor = .red
        
        bottonView.addSubview(reduceOffset)
        bottonView.addSubview(addOffset)
        bottonView.addSubview(counterLbl)
        
        reduceOffset.topAnchor.constraint(equalTo: bottonView.topAnchor, constant: 5).isActive = true
        reduceOffset.leftAnchor.constraint(equalTo: bottonView.leftAnchor, constant: 10).isActive = true
        reduceOffset.heightAnchor.constraint(equalToConstant: 45).isActive = true
        reduceOffset.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        addOffset.topAnchor.constraint(equalTo: bottonView.topAnchor, constant: 5).isActive = true
        addOffset.rightAnchor.constraint(equalTo: bottonView.rightAnchor, constant:  -10).isActive = true
        addOffset.heightAnchor.constraint(equalToConstant: 45).isActive = true
        addOffset.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        counterLbl.topAnchor.constraint(equalTo: bottonView.topAnchor, constant: 5).isActive = true
        counterLbl.leftAnchor.constraint(equalTo: reduceOffset.rightAnchor).isActive = true
        counterLbl.rightAnchor.constraint(equalTo: addOffset.leftAnchor).isActive = true
        counterLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        enabledButtons()
    }
    @objc
    func reduceOffset(sender: UIButton){
        enabledButtons()
        if collectionCellSelected == 0{
            comicsOffset -= 20
            principalListPresenter.getComics(offset: String(comicsOffset))
        }else if collectionCellSelected == 1{
            characterOffset -= 20
            principalListPresenter.getCharacters(offset: String(characterOffset))
        }
        enabledButtons()
    }
    
    @objc
    func addOffset(sender: UIButton){
        
        if collectionCellSelected == 0{
            comicsOffset += 20
            principalListPresenter.getComics(offset: String(comicsOffset))
        }else if collectionCellSelected == 1{
            characterOffset += 20
            principalListPresenter.getCharacters(offset: String(characterOffset))
        }
        enabledButtons()
    }
    
    func enabledButtons(){
        if collectionCellSelected == 0{
            if comicsOffset == 0{
                reduceOffset.isEnabled = false
                reduceOffset.alpha = 0.5
            }else if comicsOffset > (comicsTotal - 20){
                addOffset.isEnabled = false
                addOffset.alpha = 0.5
            }else{
                reduceOffset.isEnabled = true
                reduceOffset.alpha = 1
            }
            
            counterLbl.text = "\(comicsOffset + 20)/\(comicsTotal)"
        }else if collectionCellSelected == 1{
            if characterOffset == 0{
                reduceOffset.isEnabled = false
                reduceOffset.alpha = 0.5
            }else if characterOffset > (charactersTotal - 20){
                addOffset.isEnabled = false
                addOffset.alpha = 0.5
            }else {
                reduceOffset.isEnabled = true
                reduceOffset.alpha = 1
            }
            counterLbl.text = "\(characterOffset + 20)/\(charactersTotal)"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        
        if tableView == comicsTbl{
            rows = comicData.count
        }else if tableView == charactersTbl{
            rows = characterData.count
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        
        
        if tableView == comicsTbl{
            let comic: ComicStruct = comicData[indexPath.row] as ComicStruct
            
            
            cell.setImageImg(urlString: "\(comic.thumbnail?.path ?? "").\(comic.thumbnail?.extension ?? "")")
            cell.setTitleLbl(titleLbl: comic.title ?? nf)
            cell.setDescriptionLbl(descriptionLbl: comic.description ?? nf)
            
            for price in comic.prices ?? []{
                let p: PriceStruct = price
                
                if p.type == "printPrice"{
                    cell.setPriceLbl(priceLbl: "$\(String(p.price ?? 0))")
                }
            }
            
            for date in comic.dates ?? []{
                let d: DateStruct = date
                
                if d.type == "focDate"{
                    cell.setDateLbl(dateLbl: d.date ?? nf)
                }
            }
            
            cell.setIDLbl(IDLbl: String(comic.id ?? 0))
            cell.setResourceLbl(resourceLbl: comic.resourceURI ?? "")
            
            cell.createComicCell()
        }else if tableView == charactersTbl{
            let character: CharacterStruct = characterData[indexPath.row] as CharacterStruct
            
            cell.setImageImg(urlString: "\(character.thumbnail?.path ?? "").\(character.thumbnail?.extension ?? "")")
            cell.setTitleLbl(titleLbl: character.name ?? nf)
            cell.setComicsLbl(comicsLbl: String((character.comics?.returned) ?? 0))
            cell.setSeriesLbl(seriesLbl: String((character.series?.returned) ?? 0))
            cell.setEventsLbl(eventsLbl: String((character.events?.returned) ?? 0))
            cell.setStoriesLbl(storiesLbl: String((character.stories?.returned) ?? 0))
            cell.setModifiedLbl(modifiedLbl: character.modified ?? nf)
            
            cell.setIDLbl(IDLbl: String(character.id ?? 0))
            cell.setResourceLbl(resourceLbl: character.resourceURI ?? "")
            
            cell.crateCharacterCell()
        }
        
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ListTableViewCell
        resourceURISelected = cell.getResourceLbl()
        if collectionCellSelected == 0{
            resourceURISelected = cell.getResourceLbl()
            self.performSegue(withIdentifier: "comicDetailSegue", sender: nil)
        }else if collectionCellSelected == 1{
            resourceURISelected = cell.getResourceLbl()
            self.performSegue(withIdentifier: "characterDetailSegue", sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var size: CGFloat = 0
        
        if tableView == comicsTbl{
            size = 210
        }else if tableView == charactersTbl{
            size = 180
        }
        return size
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == "comicDetailSegue") {
            let vc = segue.destination as! ComicDetailViewController
            vc.resourceURI = resourceURISelected
        }else if (segue.identifier == "characterDetailSegue") {
            let vc = segue.destination as! CharacterDetailViewController
            vc.resourceURI = resourceURISelected
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCellItem: TabLayoutCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! TabLayoutCollectionViewCell
        
        if indexPath.row == collectionCellSelected{
            collectionCellItem.title.attributedText = NSAttributedString(string: menu[indexPath.row], attributes:
                                                                            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        }else{
            collectionCellItem.title.attributedText = NSAttributedString(string: menu[indexPath.row])
        }
        
        collectionCellItem.index.text = String(indexPath.row + 1)
        collectionCellItem.createCell()
        
        return collectionCellItem
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionCellSelected = indexPath.row
        
        self.tabLayout.reloadData()
        
        if collectionCellSelected == 0{
            comicsTbl.isHidden = false
            charactersTbl.isHidden = true
            
        }else if collectionCellSelected == 1{
            comicsTbl.isHidden = true
            charactersTbl.isHidden = false
        }
        enabledButtons()

        
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
