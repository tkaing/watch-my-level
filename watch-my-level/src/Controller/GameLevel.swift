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
    
    public static var onProcess: Bool = false
    
    var pairs: [Int] = []
    
    var cards: [Card] = [
        Card(id: 1),
        Card(id: 1),
        Card(id: 2),
        Card(id: 2),
        Card(id: 3),
        Card(id: 3),
        Card(id: 4),
        Card(id: 4),
        Card(id: 5),
        Card(id: 5),
        Card(id: 6),
        Card(id: 6)
    ]
    
    var storedIndex: Int?
    
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
    
    func doSomething(index: Int) {
    
        if let currentIndex = self.storedIndex {
            
            if self.cards[currentIndex].id == self.cards[index].id {
                
                self.pairs.append(currentIndex)
                self.pairs.append(index)
                
            } else {
                
                let currentCell = self.getCell(index: currentIndex) as! CardCell
                let cell = self.getCell(index: index) as! CardCell
                
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
        
        print(GameLevel.onProcess)
        
        if GameLevel.onProcess == false && self.pairs.contains(indexPath.row) == false {
            
            GameLevel.onProcess = true
            
            let cell = collectionView.cellForItem(at: indexPath) as! CardCell
            
            cell.showCard(true, animted: false)
            
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timerX) in
                
                self.doSomething(index: indexPath.row)
                
                GameLevel.onProcess = false
            }
        }
            
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func getCell(index: Int) -> UICollectionViewCell? {
        
        for (i, cell) in self.CL_PLATFORM.visibleCells.enumerated() {
            
            if i == index { return cell }
        }
        
        return nil
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
