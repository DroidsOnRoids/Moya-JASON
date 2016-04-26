//
//  Mappable.swift
//  Moya-JASON
//
//  Created by Sunshinejr on 04/26/2016.
//  Copyright (c) 2016 Droids On Roids. All rights reserved.
//

import JASON

public protocol Mappable {
    init(_ json: JSON) throws
}