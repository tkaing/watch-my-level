//
//  CardService.swift
//  Ecologie
//
//  Created by Mohamed dennoun on 04/05/2019.
//  Copyright © 2019 Dt. All rights reserved.
//

import Alamofire

public class CardService: RequestService<Card> {
    
    public static let `default` = CardService()
    
    let ROUTE_BASE = "media/"
    
    private override init () {
        // code...
    }
    
    public func find(id: String, complete: @escaping (Card) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + id
        
        self.find(address: route) { (card) in
            
            complete(card)
        }
    }
    
    public func create(card: Card, complete: @escaping (Int) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE
        
        self.create(address: route, object: card) { (status) in
            
            complete(status)
        }
    }
    
    public func update(card: Card, complete: @escaping (Int) -> Void) {
        
        guard let identifier = card.id else {
            print("id is nil")
            return
        }
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + String(identifier)
        
        self.update(address: route, object: card) { (status) in
            
            complete(status)
        }
    }
    
    public func delete(card: Card, complete: @escaping (Int) -> Void) {
        
        guard let identifier = card.id else {
            print("id is nil")
            return
        }
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + String(identifier)
        
        self.delete(address: route) { (status) in
            
            complete(status)
        }
    }
    
    public func findBy(parameters: [String : Any], complete: @escaping ([Card]) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + "criteria"
        
        self.findBy(address: route, parameters: parameters) { (cards) in
            
            complete(cards)
        }
    }
    
    public func findAll(complete: @escaping ([Card]) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE
        
        self.findAll(address: route) { (cards) in
            
            complete(cards)
        }
    }
    
    public func delete(id: String, complete: @escaping (Int) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + id
        
        self.delete(address: route) { (status) in
            
            complete(status)
        }
    }
}
