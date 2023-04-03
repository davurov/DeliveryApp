//
//  MainPageVC.swift
//  DeliveryApp
//
//  Created by Abduraxmon on 03/04/23.
//

import UIKit

class MainPageVC: UIViewController, ModelDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var categoryBtns: [UIButton]!
    
    var lastContentOffset: CGFloat = 0
    let model = Model()
    var pizzas = [ProductModelElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.getPizzas()
        model.delegate = self
        setUpTableView()
        setUpCollectionView()
        giveBorders()
        
        
    }
    
    @IBAction func categoryBtnsPressed(_ sender: UIButton) {
        for btn in categoryBtns {
            if sender.tag == btn.tag {
                categoryBtns[btn.tag].alpha = 1.0
                categoryBtns[btn.tag].layer.borderWidth = 1
                categoryBtns[btn.tag].layer.borderColor = UIColor.clear.cgColor
            } else {
                categoryBtns[btn.tag].alpha = 0.4
                categoryBtns[btn.tag].layer.borderWidth = 1
                categoryBtns[btn.tag].layer.borderColor = UIColor.red.cgColor
            }
        }
    }
    
    func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "DiscountCell", bundle: nil), forCellWithReuseIdentifier: "cell1")
    }
    
    func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "tabCell")
    }
    
    func giveBorders() {
        for btn in categoryBtns {
            if btn.tag != 0 {
                categoryBtns[btn.tag].layer.borderWidth = 1
                categoryBtns[btn.tag].layer.borderColor = UIColor.red.cgColor
            }
        }
    }
    
    func dataFetch(_ videos: ProductModel) {
        pizzas = videos
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension MainPageVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectidonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 300, height: 112)
    }
}


extension MainPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pizzas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tabCell", for: indexPath) as! ProductCell
        let pizza = pizzas[indexPath.row]
        
        cell.setCell(pizza)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
}

extension MainPageVC: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.lastContentOffset < scrollView.contentOffset.y {
            // did move up
            UIView.animate(withDuration: 0.1) { [self] in
                collectionView.isHidden = true
            }
        } else if self.lastContentOffset > scrollView.contentOffset.y {
            // did move down
            self.collectionView.isHidden = false
        } else {
        }
    }
}

