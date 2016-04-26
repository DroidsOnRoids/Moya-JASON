//
//  Response+ModelMapper.swift
//  Pods
//
//  Created by sunshinejr on 02.02.2016.
//  Copyright © 2016 sunshinejr. All rights reserved.
//

import Foundation
import Moya
import Mapper

public extension Response {
    
    public func mapObject<T: Mappable>() throws -> T {
        guard let jsonDictionary = try mapJSON() as? NSDictionary, object = T.from(jsonDictionary) else {
            throw Error.JSONMapping(self)
        }
        
        return object
    }
    
    public func mapObject<T: Mappable>(withKeyPath keyPath: String?) throws -> T {
        guard let keyPath = keyPath else { return try mapObject() }
        
        guard let jsonDictionary = try mapJSON() as? NSDictionary,
            let objectDictionary = jsonDictionary.valueForKeyPath(keyPath) as? NSDictionary,
            let object = T.from(objectDictionary) else {
                throw Error.JSONMapping(self)
        }
        
        return object
    }
    
    public func mapArray<T: Mappable>() throws -> [T] {
        guard let jsonArray = try mapJSON() as? NSArray, object = T.from(jsonArray) else {
            throw Error.JSONMapping(self)
        }
        
        return object
    }
    
    public func mapArray<T: Mappable>(withKeyPath keyPath: String?) throws -> [T] {
        guard let keyPath = keyPath else { return try mapArray() }
        
        guard let jsonDictionary = try mapJSON() as? NSDictionary,
            let objectArray = jsonDictionary.valueForKeyPath(keyPath) as? NSArray,
            let object = T.from(objectArray) else {
                throw Error.JSONMapping(self)
        }
        
        return object
    }
}