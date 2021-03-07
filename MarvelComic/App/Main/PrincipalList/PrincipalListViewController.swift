//
//  PrincipalListViewController.swift
//  MarvelComic
//
//  Created by Test on 05/03/21.
//

import UIKit

class PrincipalListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    private var principalListPresenter: PrincipalListPresenter = PrincipalListPresenter(service: ComicConector())
    
    let nf = "Not found"
    
    var menu: Array = [String]()
    var collectionCellSelected = 0
    
    var comicData: [ComicStruct] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu.append("Comics")
        menu.append("Characters")
        
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "red_226_54_54")
        
        tabLayout.delegate = self
        tabLayout.dataSource = self
        tabLayout.register(TabLayoutCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        
        listTbl.delegate = self
        listTbl.dataSource = self
        listTbl.layer.backgroundColor = UIColor.clear.cgColor
        listTbl.backgroundColor = .clear
        listTbl.register(ListTableViewCell.self, forCellReuseIdentifier: "cell")
        
        createView()
        
        principalListPresenter.attachView(view: self)
        principalListPresenter.getComics()
        
        
    }
    
    func reloadTable(data: [ComicStruct]){
        comicData = data
        DispatchQueue.main.async {
            self.listTbl.reloadData()
        }
    }
    
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
    
    private let listTbl: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    func createView(){
        view.addSubview(tabLayout)
        view.addSubview(listTbl)
        
        tabLayout.topAnchor.constraint(equalTo: view.topAnchor, constant: Sesion.instance.topPading).isActive = true
        tabLayout.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tabLayout.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tabLayout.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        listTbl.topAnchor.constraint(equalTo: tabLayout.bottomAnchor).isActive = true
        listTbl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        listTbl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        listTbl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        
        rows = comicData.count
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        
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
        
        cell.createCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var size: CGFloat = 0
        
        size = 210
        return size
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
