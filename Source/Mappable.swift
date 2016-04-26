//
//  Mappable.swift
//  Moya-JASON
//
//  Created by Sunshinejr on 02.02.2016.
//  Copyright © 2016 Droids On Roids. All rights reserved.
//

import JASON

public protocol Mappable {
    init(_ json: JSON) throws
}