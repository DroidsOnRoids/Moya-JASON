//
//  Observable+ModelMapper.swift
//  Pods
//
//  Created by sunshinejr on 03.02.2016.
//  Copyright © 2016 sunshinejr. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import JASON

/// Extension for processing Responses into Mappable objects through ObjectMapper
public extension ObservableType where E == Response {
    
    /// Maps data received from the signal into an object (on the default Background thread) which
    /// implements the Mappable protocol and returns the result back on the MainScheduler.
    /// If the conversion fails, the signal errors.
    public func mapObject<T: Mappable>(type: T.Type, keyPath: String? = nil) -> Observable<T> {
        return observeOn(SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
            .flatMap { response -> Observable<T> in
                guard let keyPath = keyPath else {
                    return Observable.just(try response.mapObject())
                }
                
                return Observable.just(try response.mapObject(withKeyPath: keyPath))
            }
            .observeOn(MainScheduler.instance)
    }
    
    /// Maps data received from the signal into an array of objects (on the default Background thread)
    /// which implement the Mappable protocol and returns the result back on the MainScheduler
    /// If the conversion fails, the signal errors.
    public func mapArray<T: Mappable>(type: T.Type, keyPath: String? = nil) -> Observable<[T]> {
        return observeOn(SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
            .flatMap { response -> Observable<[T]> in
                guard let keyPath = keyPath else {
                    return Observable.just(try response.mapArray())
                }
                
                return Observable.just(try response.mapArray(withKeyPath: keyPath))
            }
            .observeOn(MainScheduler.instance)
    }
}
