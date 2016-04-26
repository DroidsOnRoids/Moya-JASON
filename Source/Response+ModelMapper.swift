//
//  Response+ModelMapper.swift
//  Moya-JASON
//
//  Created by Sunshinejr on 04/26/2016.
//  Copyright (c) 2016 Droids On Roids. All rights reserved.
//

import Moya
import JASON

public extension Response {
    
    public func mapObject<T: Mappable>() throws -> T {
        let json = JSON(data)
        return try T.init(json)
    }
 
    public func mapObject<T: Mappable>(withKeyPath keyPath: String?) throws -> T {
        let json = JSON(data)
        let jsonKeyPath = json[path: keyPath]
        return try T.init(jsonKeyPath)
    }
    
    public func mapArray<T: Mappable>() throws -> [T] {
        let json = JSON(data)
        let object = try json.map({ json -> T in
            return try T.init(json)
        })
        
        return object
    }
    
    public func mapArray<T: Mappable>(withKeyPath keyPath: String?) throws -> [T] {
        let json = JSON(data)[path: keyPath]
        let object = try json.map({ json -> T in
            return try T.init(json)
        })
        
        return object
    }
}