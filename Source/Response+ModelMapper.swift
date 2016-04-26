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
    
    public func mapObject<T: Mappable>() -> T {
        let json = JSON(data)
        return T.init(json)
    }
 
    public func mapObject<T: Mappable>(withKeyPath keyPath: [Any]) -> T {
        let json = JSON(data)[path: keyPath]
        return T.init(json)
    }
    
    public func mapArray<T: Mappable>() -> [T] {
        let json = JSON(data)
        return json.map(T.init)
    }
    
    public func mapArray<T: Mappable>(withKeyPath keyPath: [Any]) -> [T] {
        let json = JSON(data)[path: keyPath]
        return json.map(T.init)
    }
}