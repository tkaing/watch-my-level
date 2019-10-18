//
//  ProductService.swift
//  Ecologie
//
//  Created by Mohamed dennoun on 04/05/2019.
//  Copyright © 2019 Dt. All rights reserved.
//

import Alamofire

public class ProductService: RequestService<Product> {
    
    public static let `default` = ProductService()
    
    let ROUTE_BASE = "product/"
    
    private override init () {
        // code...
    }
    
    public func find(id: String, complete: @escaping (Product) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + id
        
        self.find(address: route) { (product) in
            
            complete(product)
        }
    }
    
    public func create(product: Product, complete: @escaping (Int) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE
        
        self.create(address: route, object: product) { (status) in
            
            complete(status)
        }
    }
    
    public func update(product: Product, complete: @escaping (Int) -> Void) {
        
        guard let identifier = product.id else {
            print("id is nil")
            return
        }
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + String(identifier)
        
        self.update(address: route, object: product) { (status) in
            
            complete(status)
        }
    }
    
    public func delete(product: Product, complete: @escaping (Int) -> Void) {
        
        guard let identifier = product.id else {
            print("id is nil")
            return
        }
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + String(identifier)
        
        self.delete(address: route) { (status) in
            
            complete(status)
        }
    }
    
    public func findBy(parameters: [String : Any], complete: @escaping ([Product]) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + "criteria"
        
        self.findBy(address: route, parameters: parameters) { (products) in
            
            complete(products)
        }
    }
    
    public func findAll(complete: @escaping ([Product]) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE
        
        self.findAll(address: route) { (products) in
            
            complete(products)
        }
    }
    
    public func delete(id: String, complete: @escaping (Int) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + id
        
        self.delete(address: route) { (status) in
            
            complete(status)
        }
    }
}
