//
//  UserServices.swift
//  Ecologie
//
//  Created by Mohamed dennoun on 04/05/2019.
//  Copyright © 2019 Dt. All rights reserved.
//

import Alamofire

public class UserService: RequestService<User>  {
    
    public static let `default` = UserService()
    
    let ROUTE_BASE = "user/"
    
    private override init () {
        // code...
    }
    
    public func find(id: String, complete: @escaping (User) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + id
        
        self.find(address: route) { (course) in
            
            complete(course)
        }
    }
    
    public func create(user: User, complete: @escaping (Int) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE
        
        self.create(address: route, object: user) { (status) in
            
            complete(status)
        }
    }
    
    public func authenticate(data: [String: Any], complete: @escaping (User?) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + "login"
        
        Alamofire.request(route, method: .post, parameters: data, encoding: JSONEncoding.default)
            .responseJSON { (request) in
                
                guard let item = request.value as? [String: Any]
                    else { return }
                
                guard let status = request.response?.statusCode
                    else { return }
                
                if status == 200 {
                    
                    guard let object = User(JSON: item)
                        else { return }
                    
                    complete(object)
                    
                } else {
                    
                    complete(nil)
                }
        }
    }
    
    public func update(user: User, complete: @escaping (Int) -> Void) {
        
        guard let identifier = user.id else {
            print("id is nil")
            return
        }
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + String(identifier)
        
        self.update(address: route, object: user) { (status) in
            
            complete(status)
        }
    }
    
    public func findBy(parameters: [String: Any], complete: @escaping ([User]) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + "criteria"
        
        self.findBy(address: route, parameters: parameters) { (users) in
            
            complete(users)
        }
    }
    
    public func findAll(complete: @escaping ([User]) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE
        
        self.findAll(address: route) { (users) in
            
            complete(users)
        }
    }
    
    public func delete(id: String, complete: @escaping (Int) -> Void) {
        
        let route = self.API_DEFAULT + self.ROUTE_BASE + id
        
        self.delete(address: route) { (status) in
            
            complete(status)
        }
    }
}
