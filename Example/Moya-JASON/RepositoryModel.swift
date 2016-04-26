//
//  RepositoryModel.swift
//  Moya-JASON
//
//  Created by Sunshinejr on 04/26/2016.
//  Copyright (c) 2016 Droids On Roids. All rights reserved.
//

import JASON
import Moya_JASON

private extension JSONKeys {
    static let id       = JSONKey<Int>("id")
    static let language = JSONKey<String>("language")
    static let url      = JSONKey<String?>("url")
}

struct Repository: Mappable {
    
    let identifier: Int
    let language: String
    let url: String?
    
    init(_ json: JSON) throws {
        identifier  = json[.id]
        language    = json[.language]
        url         = json[.url]
    }
}