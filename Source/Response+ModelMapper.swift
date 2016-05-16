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
    
    public func mapObject<T: Mappable>(withKeyPath keyPath: [Any] = []) throws -> T {
        let json = keyPath.reduce(JSON(data)) { json, currentKeypath in
            return json[path: currentKeypath]
        }
        return try T.init(json)
    }
    
    public func mapArray<T: Mappable>(withKeyPath keyPath: [Any] = []) throws -> [T] {
        let json = keyPath.reduce(JSON(data)) { json, currentKeypath in
            return json[path: currentKeypath]
        }
        let object = try json.map({ json -> T in
            return try T.init(json)
        })
        
        return object
    }
}
