//
//  ObjectService.swift
//  Ecologie
//
//  Created by Thierry Kg on 09/05/2019.
//  Copyright © 2019 Dt. All rights reserved.
//

import Alamofire
import ObjectMapper

public class RequestService<T: ImmutableMappable>
{
    let API_DEFAULT = "http://localhost:6789/"
    
    func create(address: String, object: T, complete: @escaping (Int) -> Void) {

        Alamofire.request(address, method: .post, parameters: object.toJSON(), encoding: JSONEncoding.default).responseJSON { (request) in
            
            guard let status = request.response?.statusCode
                else { return }
            
            complete(status)
        }
    }
    
    func find(address: String, complete: @escaping (T) -> Void) {
        
        Alamofire.request(address).responseJSON { (request) in
            
            guard let item = request.value as? [String: Any]
                else { return }
            
            guard let object = (try? T(JSON: item))
                else { return }
            
            guard let status = request.response?.statusCode
                else { return }
            
            // Show popup
            self.requestStatus(status: status)
            
            // Execute callback / closure
            complete(object)
        }
    }
    
    func findBy(address: String, parameters: [String: Any], complete: @escaping ([T]) -> Void) {
        
        var objects: [T] = []
        
        Alamofire.request(address, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { (request) in
                
                guard let items = request.value as? [[String: Any]]
                    else { return }
                
                for item in items {
                    
                    guard let object = (try? T(JSON: item))
                        else { return }
                    
                    objects.append(object)
                }
                
                // Execute callback / closure
                complete(objects)
        }
    }
    
    func findAll(address: String, complete: @escaping ([T]) -> Void) {
        
        var objects: [T] = []
        
        Alamofire.request(address).responseJSON { (request) in
            
            guard let items = request.value as? [[String: Any]]
                else { return }
            
            for item in items {
                
                guard let object = (try? T(JSON: item))
                    else { return }
                
                objects.append(object)
            }
            
            // Execute callback / closure
            complete(objects)
        }
    }
    
    func update(address: String, object: T, complete: @escaping (Int) -> Void) {
        
        Alamofire.request(address, method: .put, parameters: object.toJSON(), encoding: JSONEncoding.default).responseJSON { (request) in
            
            guard let status = request.response?.statusCode
                else { return }
            
            // Show popup
            self.requestStatus(status: status)
            
            // Execute callback / closure
            complete(status)
        }
    }
    
    func delete(address: String, complete: @escaping (Int) -> Void) {
        
        Alamofire.request(address, method: .delete).responseJSON { (request) in
            
            guard let status = request.response?.statusCode
                else { return }
            
            // Show popup
            self.requestStatus(status: status)
            
            // Execute callback / closure
            complete(status)
        }
    }
    
    // Alert Box & Errors
    
    func requestStatus(status: Int) -> Void {
        
        switch (status) {
        case 200:
            print("status 200")
        case 404:
            print("status 404")
        case 422:
            print("status 422")
        default:
            print("status 500 (Internal Serveur Error)")
        }
    }
}
