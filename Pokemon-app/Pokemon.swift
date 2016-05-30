//
//  Pokemon.swift
//  Pokemon-app
//
//  Created by Dan Hyunchan Kim on 5/25/16.
//  Copyright © 2016 hyunchan. All rights reserved.
//

import Foundation

class Pokemon
{
    private var _name: String!
    private var _monIdxId: Int!
    
    var name: String
        {
        return _name
    }
    
    var monIdxId: Int
        {
        return _monIdxId
    }
    
    init(name: String, monIdxId: Int)
    {
        self._name = name
        self._monIdxId = monIdxId
    }
}