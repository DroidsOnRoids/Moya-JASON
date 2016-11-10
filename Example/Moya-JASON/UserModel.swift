//
//  UserModel.swift
//  Moya-JASON
//
//  Created by Sunshinejr on 04/26/2016.
//  Copyright (c) 2016 Droids On Roids. All rights reserved.
//

import JASON
import Moya_JASON

public enum UserParsingError: Error {
    case login
}

private extension JSONKeys {
    static let login = JSONKey<String>("login")
}

struct User: Mappable {
    
    let login: String
    
    init(_ json: JSON) throws {
        login = json[.login]
        if login.isEmpty {
            throw UserParsingError.login
        }
    }
}
