//
//  ViewController.swift
//  Moya-JASON
//
//  Created by Sunshinejr on 04/26/2016.
//  Copyright (c) 2016 Droids On Roids. All rights reserved.
//

import UIKit
import Moya
import Moya_JASON
import JASON

class ViewController: UIViewController {
    
    var provider: MoyaProvider<GitHub>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    /// Function to setup Moya Provider & request in the beginning
    /// of the VC lifecycle. For testing purposes it fires up
    /// instantly.
    func setup() {
        provider = MoyaProvider<GitHub>()
        
        // Example of mapping array of objects
        provider.request(GitHub.Repos("mjacko")) { (result) in
            if case .Success(let response) = result {
                let repositories: [Repository] = response.mapArray()
                print(repositories)
            }
        }
    }
}
