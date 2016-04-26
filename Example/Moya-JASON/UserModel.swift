//
//  UserModel.swift
//  Moya-JASON
//
//  Created by Lukasz Mroz on 26.04.2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import JASON
import Moya_JASON

public enum UserParsingError: ErrorType {
    case Login
}

private extension JSONKeys {
    static let login = JSONKey<String>("login")
}

struct User: Mappable {
    
    let login: String
    
    init?(_ json: JSON) throws {
        login = json[.login]
        if login.isEmpty {
            throw UserParsingError.Login
        }
    }
}
