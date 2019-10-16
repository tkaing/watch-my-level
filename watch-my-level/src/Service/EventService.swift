//
//  EventService.swift
//  Ecologie
//
//  Created by Mohamed dennoun on 04/05/2019.
//  Copyright © 2019 Dt. All rights reserved.
//

import Alamofire

public class EventService: RequestService<Event> {
    
    public static let `default` = EventService()
    
    let ROUTE_BASE = "event/"
    
    private override init () {
        // code...
    }
    
    public func find(id: String, complete: @escaping (Event) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + id
        
        self.find(address: route) { (event) in
            
            complete(event)
        }
    }
    
    public func create(event: Event, complete: @escaping (Int) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE
        
        self.create(address: route, object: event) { (status) in
            
            complete(status)
        }
    }
    
    public func update(event: Event, complete: @escaping (Int) -> Void) {
        
        guard let identifier = event.id else {
            print("id is nil")
            return
        }
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + String(identifier)
        
        self.update(address: route, object: event) { (status) in
            
            complete(status)
        }
    }
    
    public func delete(event: Event, complete: @escaping (Int) -> Void) {
        
        guard let identifier = event.id else {
            print("id is nil")
            return
        }
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + String(identifier)
        
        self.delete(address: route) { (status) in
            
            complete(status)
        }
    }
    
    public func findBy(parameters: [String : Any], complete: @escaping ([Event]) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + "criteria"
        
        self.findBy(address: route, parameters: parameters) { (events) in
            
            complete(events)
        }
    }
    
    public func findAll(complete: @escaping ([Event]) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE
        
        self.findAll(address: route) { (events) in
            
            complete(events)
        }
    }
    
    public func delete(id: String, complete: @escaping (Int) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + id
        
        self.delete(address: route) { (status) in
            
            complete(status)
        }
    }
}
