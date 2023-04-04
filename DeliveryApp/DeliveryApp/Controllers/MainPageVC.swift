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
    
    var cellIndex = 0
    var lastContentOffset: CGFloat = 0
    let model = Model()
    var pizzas = [ProductModelElement]()
    var discountRanges = [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0), IndexPath(row: 2, section: 0), IndexPath(row: 3, section: 0), IndexPath(row: 4, section: 0), IndexPath(row: 5, section: 0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.getPizzas()
        model.delegate = self
        setUpTableView()
        setUpCollectionView()
        giveBorders()
        giveAlpha()
        
        //------------right  swipe gestures in collectionView--------------//
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(rightSwiped))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.collectionView.addGestureRecognizer(swipeRight)
        
        //-----------left swipe gestures in collectionView--------------//
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(leftSwiped))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.collectionView.addGestureRecognizer(swipeLeft)
        
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
    
    func dataFetch(_ data: ProductModel) {
        pizzas = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func leftSwiped() {
        if cellIndex < discountRanges.count - 1 {
            collectionView.scrollToNextItem()
            cellIndex += 1
            giveAlpha()
        }
    }
    
    @objc func rightSwiped() {
        if cellIndex != 0 {
            collectionView.scrollToPreviousItem()
            cellIndex -= 1
            giveAlpha()
        }
    }
    
    func giveAlpha() {
        for i in discountRanges {
            if i.row == cellIndex {
                collectionView.cellForItem(at: i)?.alpha = 1
            } else {
                collectionView.cellForItem(at: i)?.alpha = 0.4
            }
        }
    }
    
}

extension MainPageVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectidonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        discountRanges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! DiscountCell
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 300, height: 112)
    }
}


extension MainPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !pizzas.isEmpty {
            return pizzas.count
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tabCell", for: indexPath) as! ProductCell
        
        
        if !pizzas.isEmpty {
            let pizza = pizzas[indexPath.row]
            cell.setCell(pizza)
        }
        
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
                tableView.layer.cornerRadius = 0
            }
        } else if self.lastContentOffset > scrollView.contentOffset.y {
            // did move down
            self.collectionView.isHidden = false
            tableView.layer.cornerRadius = 20
        } else {
        }
    }
}

extension UICollectionView {
    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x + 310))
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    func scrollToPreviousItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x - 310))
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
    }
}
