//
//  PrincipalListViewController.swift
//  MarvelComic
//
//  Created by Test on 05/03/21.
//

import UIKit

class PrincipalListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
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
    
    var filterComics: [FilterStruct] = []
    var filterCharacters: [FilterStruct] = []
    
    var filterComicsSelected: String = ""
    var filterCharactersSelected: String = ""
    var filterComicsSelectedDescription: String = ""
    var filterCharactersSelectedDescription: String = ""
    
    var hiddenGesture:UITapGestureRecognizer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu.append("Comics")
        menu.append("Characters")
        
        filterComics = Filter().filterComic()
        filterCharacters = Filter().filterCharacter()
        
        self.view.backgroundColor = .black
        
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
        
        filtersTbl.delegate = self
        filtersTbl.dataSource = self
        filtersTbl.register(ListTableViewCell.self, forCellReuseIdentifier: "cell")
        
        createView()
        
        principalListPresenter.attachView(view: self)
        principalListPresenter.getComics(offset: String(comicsOffset), filter: filterComicsSelected, textFilter: textFilterTxt.text ?? "")
        principalListPresenter.getCharacters(offset: String(comicsOffset), filter: filterCharactersSelected, textFilter: textFilterTxt.text ?? "")
        
        filterTxt.delegate = self
        textFilterTxt.delegate = self
        
        hiddenGesture = UITapGestureRecognizer(target: self, action: #selector(hidenControl(_:)))
        self.view.addGestureRecognizer(hiddenGesture!)
        hiddenGesture?.isEnabled = false
    }
    
    @IBAction func hidenControl(_ sender: AnyObject) {
        textFilterTxt.endEditing(true)
        hiddenGesture?.isEnabled = false
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
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let marvelLogo: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "marvelLogo")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let filterTxt:UITextField = {
       let textfield = UITextField()
        textfield.textAlignment = .center
        textfield.placeholder = "Filter"
        textfield.backgroundColor = .white
        textfield.layer.cornerRadius = 10
        textfield.layer.borderWidth = 2
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.tag = 1
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let textFilterTxt:UITextField = {
       let textfield = UITextField()
        textfield.textAlignment = .center
        textfield.placeholder = "Search.."
        textfield.backgroundColor = .white
        textfield.layer.cornerRadius = 10
        textfield.layer.borderWidth = 2
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.tag = 2
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let findBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "iconFinder"), for: .normal)
        button.backgroundColor = .white
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.cornerRadius = 22
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action:#selector(filterFind(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    private let shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let filtersTbl:UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.layer.cornerRadius = 10
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var tableTopConstraint = NSLayoutConstraint()
    var tableHeightContraint = NSLayoutConstraint()
    
    func createView(){
        
        view.addSubview(tabLayout)
        view.addSubview(comicsTbl)
        view.addSubview(charactersTbl)
        view.addSubview(bottonView)
        view.addSubview(topView)
        
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Sesion.instance.topPading * 3.5).isActive = true
        
        topView.addSubview(marvelLogo)
        topView.addSubview(filterTxt)
        topView.addSubview(textFilterTxt)
        topView.addSubview(findBtn)
        
        marvelLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: Sesion.instance.topPading).isActive = true
        marvelLogo.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        marvelLogo.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        marvelLogo.heightAnchor.constraint(equalToConstant: Sesion.instance.topPading).isActive = true
        
        filterTxt.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 5).isActive = true
        filterTxt.topAnchor.constraint(equalTo: marvelLogo.bottomAnchor, constant: 3).isActive = true
        filterTxt.widthAnchor.constraint(equalToConstant: 120).isActive = true
        filterTxt.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        textFilterTxt.leftAnchor.constraint(equalTo: filterTxt.rightAnchor, constant: 5).isActive = true
        textFilterTxt.rightAnchor.constraint(equalTo: findBtn.leftAnchor, constant: -5).isActive = true
        textFilterTxt.topAnchor.constraint(equalTo: marvelLogo.bottomAnchor, constant: 3).isActive = true
        textFilterTxt.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        findBtn.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -5).isActive = true
        findBtn.topAnchor.constraint(equalTo: marvelLogo.bottomAnchor, constant: 3).isActive = true
        findBtn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        findBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        tabLayout.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
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
        
        view.addSubview(shadowView)
        view.addSubview(filtersTbl)
        
        shadowView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        shadowView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        shadowView.isHidden = true
        
        filtersTbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        filtersTbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        tableTopConstraint = filtersTbl.topAnchor.constraint(equalTo: view.bottomAnchor)
        tableHeightContraint = filtersTbl.heightAnchor.constraint(equalTo: textFilterTxt.heightAnchor)
        NSLayoutConstraint.activate([
            tableTopConstraint,
            tableHeightContraint
        ])
    }
    @objc
    func reduceOffset(sender: UIButton){
        enabledButtons()
        if collectionCellSelected == 0{
            comicsOffset -= 20
            principalListPresenter.getComics(offset: String(comicsOffset), filter: filterComicsSelected, textFilter: textFilterTxt.text ?? "")
        }else if collectionCellSelected == 1{
            characterOffset -= 20
            principalListPresenter.getCharacters(offset: String(comicsOffset), filter: filterCharactersSelected, textFilter: textFilterTxt.text ?? "")
        }
        enabledButtons()
    }
    
    @objc
    func addOffset(sender: UIButton){
        
        if collectionCellSelected == 0{
            comicsOffset += 20
            principalListPresenter.getComics(offset: String(comicsOffset), filter: filterComicsSelected, textFilter: textFilterTxt.text ?? "")
        }else if collectionCellSelected == 1{
            characterOffset += 20
            principalListPresenter.getCharacters(offset: String(comicsOffset), filter: filterCharactersSelected, textFilter: textFilterTxt.text ?? "")
        }
        enabledButtons()
    }
    
    @objc
    func filterFind(sender: UIButton){
        
        if collectionCellSelected == 0{
            principalListPresenter.getComics(offset: String(comicsOffset), filter: filterComicsSelected, textFilter: textFilterTxt.text ?? "")
        }else if collectionCellSelected == 1{
            principalListPresenter.getCharacters(offset: String(comicsOffset), filter: filterCharactersSelected, textFilter: textFilterTxt.text ?? "")
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
        }else if tableView == filtersTbl{
            if collectionCellSelected == 0{
                rows = filterComics.count
            }else if collectionCellSelected == 1{
                rows = filterCharacters.count
            }
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        
        cell.backgroundColor = .clear
        
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
        }else if tableView == filtersTbl{
          
            var filter: FilterStruct = FilterStruct()
            
            if collectionCellSelected == 0{
                filter = filterComics[indexPath.row]
            }else if collectionCellSelected == 1{
                filter = filterCharacters[indexPath.row]
            }
            
            cell.setTitleLbl(titleLbl: filter.description ?? "")
            cell.setIDLbl(IDLbl: filter.filterID ?? "")
            
            cell.createOptionCell()
            
            cell.backgroundColor = .white
            
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ListTableViewCell
        resourceURISelected = cell.getResourceLbl()
        if collectionCellSelected == 0{
            if tableView == comicsTbl{
                resourceURISelected = cell.getResourceLbl()
                self.performSegue(withIdentifier: "comicDetailSegue", sender: nil)
            }else if tableView == filtersTbl{
                filterTxt.text = cell.getTitleLbl()
                filterComicsSelected = cell.getIDLbl()
                filterComicsSelectedDescription = cell.getTitleLbl()
                hideTbl()
            }
        }else if collectionCellSelected == 1{
            if tableView == charactersTbl{
                resourceURISelected = cell.getResourceLbl()
                self.performSegue(withIdentifier: "characterDetailSegue", sender: nil)
            }else if tableView == filtersTbl{
                filterTxt.text = cell.getTitleLbl()
                filterCharactersSelected = cell.getIDLbl()
                filterCharactersSelectedDescription = cell.getTitleLbl()
                hideTbl()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var size: CGFloat = 0
        
        if tableView == comicsTbl{
            size = 210
        }else if tableView == charactersTbl{
            size = 180
        }else if tableView == filtersTbl{
            size = 40
        }
        return size
    }
    
    func showTbl(){
        var size:CGFloat = CGFloat(0)
        
        if collectionCellSelected == 0{
            size = CGFloat(filterComics.count * 45)
        }else if collectionCellSelected == 1{
            size = CGFloat(filterCharacters.count * 45)
        }
        
        if(size > (view.frame.size.height - 200)){
            tableHeightContraint.constant = view.frame.size.height - 300
            tableTopConstraint.constant = -(view.frame.size.height  - 140)
        }else{
            tableHeightContraint.constant = size - 60
            tableTopConstraint.constant = -(view.frame.size.height/2)-(size/2)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.shadowView.isHidden = false
            self.view.superview?.layoutIfNeeded()
        });
    }
    
    func hideTbl(){
        tableTopConstraint.constant = view.frame.size.height
        UIView.animate(withDuration: 0.3, animations: {
            self.shadowView.isHidden = true
            self.view.superview?.layoutIfNeeded()
        });
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        var response = true
        
        if textField.tag == 1{
            shadowView.isHidden = false
            showTbl()
            response = false
            textFilterTxt.endEditing(true)
            hiddenGesture?.isEnabled = false
        }else if textField.tag == 2{
            hiddenGesture?.isEnabled = true
        }
        
        return response
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionCellSelected = indexPath.row
        
        self.tabLayout.reloadData()
        self.filtersTbl.reloadData()
        
        
        if self.collectionCellSelected == 0{
            self.comicsTbl.isHidden = false
            self.charactersTbl.isHidden = true
            filterTxt.text = filterComicsSelectedDescription
        }else if self.collectionCellSelected == 1{
            self.comicsTbl.isHidden = true
            self.charactersTbl.isHidden = false
            filterTxt.text = filterCharactersSelectedDescription
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
