//
//  Response+ModelMapper.swift
//  Moya-JASON
//
//  Created by Sunshinejr on 02.02.2016.
//  Copyright © 2016 Droids On Roids. All rights reserved.
//

import Moya
import JASON

public extension Response {
    
    public func mapObject<T: Mappable>() throws -> T {
        let json = JSON(data)
        guard let object = try T.init(json) else {
            throw Error.JSONMapping(self)
        }
    
        return object
    }
 
    public func mapObject<T: Mappable>(withKeyPath keyPath: String) throws -> T {
        let json = JSON(data)
        let jsonKeyPath = json[path: keyPath]
        guard let object = try T.init(jsonKeyPath) else {
            throw Error.JSONMapping(self)
        }
        
        return object
    }
    
    public func mapArray<T: Mappable>() throws -> [T] {
        let json = JSON(data)
        let object = try json.map({ json -> T in
            guard let object = try T.init(json) else {
                throw Error.JSONMapping(self)
            }
            
            return object
        })
        
        return object
    }
    
    public func mapArray<T: Mappable>(withKeyPath keyPath: String) throws -> [T] {
        let json = JSON(data)[path: keyPath]
        let object = try json.map({ json -> T in
            guard let object = try T.init(json) else {
                throw Error.JSONMapping(self)
            }
            
            return object
        })
        
        return object
    }
}