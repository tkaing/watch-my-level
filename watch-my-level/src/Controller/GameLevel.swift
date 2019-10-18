//
//  GameLevel.swift
//  watch-my-level
//
//  Created by Viviana Montiel on 16/10/2019.
//  Copyright © 2019 wml. All rights reserved.
//

import UIKit
import SideMenu

class GameLevel: UIViewController {
    
    @IBOutlet var CL_PLATFORM: UICollectionView!
    @IBOutlet var LB_TIME: UILabel!
    @IBOutlet var RIGHT_BUTTON: UIButton!
    
    public static var level = 1
    
    var time: Int = 105
    var minute: Int = 1
    var second: Int = 45
    
    var timer: Timer = Timer()
    var first: Bool = false
    
    var pairs: [Int] = []
    var cards: [Card] = []
    
    var storedIndex: Int?
    var onProcess: Bool = false
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.initAll()
    }
    
    @IBAction func BT_NEXT(_ sender: UIButton) {
        
        let ll = Loading()
        
        self.redirectTo(from: self, to: ll)
        
        GameLevel.level += 1
        
        if GameLevel.level < 4 {
            
            CardService.default.findByLevel(id: GameLevel.level) { (cards) in
                
                let to = GameLevel()
                
                to.cards = cards
                
                self.redirectTo(from: ll, to: to)
            }
            
        } else {
            
            UserService.default.findAll(complete: { (users) in
                
                let to = Ranking()
                
                to.users = users
                
                self.redirectTo(from: ll, to: to)
            })
        }
    }
}

// Default Extension
extension GameLevel {
    
    func initAll() {
        
        // Navigation
        self.initPanel()
        self.navigationItem.title = "Game Level " + String(GameLevel.level)
        
        // Collection
        let nib = UINib(nibName: "CardCell", bundle: nil)
        self.CL_PLATFORM.delegate = self
        self.CL_PLATFORM.dataSource = self
        self.CL_PLATFORM.register(nib, forCellWithReuseIdentifier: "CardCell")
        
        // Right Button
        GameLevel.level == 3 ? self.RIGHT_BUTTON.setTitle("Classement", for: .normal) : self.RIGHT_BUTTON.setTitle("Niveau Suivant", for: .normal)
    }
}

// Navigation Extension
extension GameLevel {
    
    func initPanel() {
        
        let mm = MenuManager()
        
        let BT = mm.BT(view: self)
        
        BT.addTarget(self, action: #selector(openPanel), for: .touchUpInside)
    }
    
    @objc func openPanel() {
        
        let view: UIViewController = SideMenuManager.default.menuLeftNavigationController!
        
        present(view, animated: true, completion: nil)
    }
    
    func redirectTo(from: UIViewController, to: UIViewController) {
        
        let mm = MenuManager()
        
        mm.redirectTo(from: from, to: to)
    }
    
    func alert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Niveau Suivant", style: .default, handler: { (action) in
            
            let ll = Loading()
            
            self.redirectTo(from: self, to: ll)
            
            GameLevel.level += 1
            
            if GameLevel.level < 4 {
            
                CardService.default.findByLevel(id: GameLevel.level, complete: { (cards) in
                    
                    let to = GameLevel()
                    
                    to.cards = cards
                    
                    self.redirectTo(from: ll, to: to)
                })
                
            } else {
                
                UserService.default.findAll(complete: { (users) in
                    
                    let to = Ranking()
                    
                    to.users = users
                    
                    self.redirectTo(from: ll, to: to)
                })
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// Game Extension
extension GameLevel {
    
    func selectCard(index: Int) {
    
        if let currentIndex = self.storedIndex {
            
            if self.cards[currentIndex].id == self.cards[index].id {
                
                if currentIndex == index {
                    
                    let currentCell = self.CL_PLATFORM.cellForItem(at: IndexPath(row: currentIndex, section: 0)) as! CardCell
                    
                    currentCell.showCard(false, animted: false)
                    
                } else {
            
                    self.pairs.append(currentIndex)
                    
                    self.pairs.append(index)
                    
                    if self.pairs.count == self.cards.count {
                        
                        self.timer.invalidate()
                        
                        self.alert(title: "Féliciations !", message: "Passez au niveau suivant dès maintenant")
                    }
                }
                
            } else {

                let currentCell = self.CL_PLATFORM.cellForItem(at: IndexPath(row: currentIndex, section: 0)) as! CardCell
                
                let cell = self.CL_PLATFORM.cellForItem(at: IndexPath(row: index, section: 0)) as! CardCell
                
                currentCell.showCard(false, animted: false)
                
                cell.showCard(false, animted: false)
            }
            
            self.storedIndex = nil
            
        } else {
            
            self.storedIndex = index
        }
    }
}

// Collection Cell Extension
extension GameLevel: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    // On Init
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        
        cell.showCard(false, animted: false)
        
        return cell
    }
    
    // On Click
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let row = indexPath.row
        
        if self.first == false {
            
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
                
                if self.time == 0 {
                    
                    self.timer.invalidate()
                    
                    self.alert(title: "Temps écoulé !", message: "Tentez de gagner une prochaine fois")
                    
                } else {
                
                    if self.time % 60 == 0 {
                        self.minute -= 1
                        self.second = 60
                    }
                    
                    self.time -= 1
                    self.second -= 1
                    
                    let showMinute = String(self.minute)
                    let showSecond = self.second < 10 ? "0" + String(self.second) : String(self.second)
                    
                    self.LB_TIME.text = showMinute + ":" + showSecond
                }
            }
        }
        
        self.first = true
        
        if self.onProcess == false && self.pairs.contains(row) == false {
            
            self.onProcess = true
            
            let cell = collectionView.cellForItem(at: indexPath) as! CardCell
            
            let card = self.cards[indexPath.row]
            
            cell.showCard(true, animted: false, url: card.url)
            
            var timeInterval = 0.3
            
            if let currentIndex = self.storedIndex { timeInterval = 1.5 }
            
            Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { (timer) in
                
                self.selectCard(index: row)
                
                self.onProcess = false
            }
        }
            
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// Collection Extension
extension GameLevel: UICollectionViewDelegateFlowLayout {
    
    // Collection view flow layout setup
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let line = GameLevel.level >= 3 ? 5 : 4
        
        let paddingSpace = Int(sectionInsets.left) * line
        let availableWidth = Int(view.frame.width) - paddingSpace
        let widthPerItem = availableWidth / line
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
