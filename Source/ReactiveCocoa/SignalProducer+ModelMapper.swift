//
//  SignalProducer+ModelMapper.swift
//  Pods
//
//  Created by sunshinejr on 03.02.2016.
//  Copyright © 2016 sunshinejr. All rights reserved.
//

import ReactiveCocoa
import Moya
import Mapper

/// Extension for processing Responses into Mappable objects through ObjectMapper
extension SignalProducerType where Value == Moya.Response, Error == Moya.Error {
    
    /// Maps data received from the signal into an object which implements the Mappable protocol.
    /// If the conversion fails, the signal errors.
    public func mapObject<T: Mappable>(type: T.Type, keyPath: String? = nil) -> SignalProducer<T, Error> {
        return producer.flatMap(.Latest) { response -> SignalProducer<T, Error> in
            return unwrapThrowable { try response.mapObject(withKeyPath: keyPath) }
        }
    }
    
    /// Maps data received from the signal into an array of objects which implement the Mappable
    /// protocol.
    /// If the conversion fails, the signal errors.
    public func mapArray<T: Mappable>(type: T.Type, keyPath: String? = nil) -> SignalProducer<[T], Error> {
        return producer.flatMap(.Latest) { response -> SignalProducer<[T], Error> in
            return unwrapThrowable { try response.mapArray(withKeyPath: keyPath) }
        }
    }
}

/// Maps throwable to SignalProducer
private func unwrapThrowable<T>(throwable: () throws -> T) -> SignalProducer<T, Moya.Error> {
    do {
        return SignalProducer(value: try throwable())
    } catch {
        return SignalProducer(error: error as! Moya.Error)
    }
}