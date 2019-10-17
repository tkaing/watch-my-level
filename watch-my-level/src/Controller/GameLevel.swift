//
//  GameLevel.swift
//  watch-my-level
//
//  Created by Viviana Montiel on 16/10/2019.
//  Copyright © 2019 wml. All rights reserved.
//

import UIKit

class GameLevel: UIViewController {
    
    @IBOutlet var CL_PLATFORM: UICollectionView!
    @IBOutlet var LB_TIME: UILabel!
    
    var pairs: [Card] = []
    
    var cards: [Card] = [
        Card(id: 1),
        Card(id: 1),
        Card(id: 2),
        Card(id: 2),
        Card(id: 3),
        Card(id: 3)
    ]
    
    var activeCard: Card?
    var storedCard1: Card?
    var storedCard2: Card?
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Game Level"

        self.CL_PLATFORM.delegate = self
        self.CL_PLATFORM.dataSource = self
        
        let nib = UINib(nibName: "CardCell", bundle: nil)
        
        self.CL_PLATFORM.register(nib, forCellWithReuseIdentifier: "CardCell")
    }
}

// Game Extension
extension GameLevel {
    
    func move() {
    
        if let card001 = storedCard1, let card002 = storedCard2 {
            
            print(card001.id)
            print(card002.id)
            
            print(self.indexOf(card: card001))
            print(self.indexOf(card: card002))
            
            if card001.id == card002.id && self.indexOf(card: card001) != self.indexOf(card: card002) {
                
                print("xxx")
                
                self.pairs.append(card001)
                self.pairs.append(card002)
                
            } else {
                
                self.storedCard1 = nil
                self.storedCard2 = nil
                
                print(self.pairs)
                
                for (i, cell) in self.CL_PLATFORM.visibleCells.enumerated() {
                    
                    let c = cell as! CardCell
                    
                    if self.pairs.contains(self.cards[i]) == false {
                    
                        c.showCard(false, animted: true)
                    }
                }
            }
        }
    }
    
    func indexOf(card: Card) -> Int {
        
        for (k, c) in self.cards.enumerated() {
            if c == card {
                return k
            }
        }
        
        return -1
    }
    
    func regCurCards(card: Card) {
        
        if self.storedCard1 == nil {
            
            self.storedCard1 = card
            
        } else if self.storedCard2 == nil {
            
            self.storedCard2 = card
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
        
        if self.pairs.contains(self.cards[indexPath.row]) == false {
            
            let cell = collectionView.cellForItem(at: indexPath) as! CardCell
            
            cell.showCard(true, animted: true)
            
            self.activeCard = self.cards[indexPath.row]
            
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(xxx), userInfo: nil, repeats: false)
            
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
    
    @objc func xxx() {
        
        if let card = self.activeCard {
            
            self.regCurCards(card: card)
            
            self.move()
        }
    }
}

// Collection Extension
extension GameLevel: UICollectionViewDelegateFlowLayout {
    
    // Collection view flow layout setup
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = Int(sectionInsets.left) * 3
        let availableWidth = Int(view.frame.width) - paddingSpace
        let widthPerItem = availableWidth / 3
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
