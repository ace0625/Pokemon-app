//
//  Pokemon.swift
//  Pokemon-app
//
//  Created by Dan Hyunchan Kim on 5/25/16.
//  Copyright © 2016 hyunchan. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon
{
    private var _name: String!
    private var _monIdxId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoText: String!
    private var _nextEvoId: String!
    private var _nextEvoLvl: String!
    private var _monsterUrl: String!
    
    
    //<<<<<<<<<<<<<<<< Encapsulation
    var name: String
    {
        return _name
    }
    
    var monIdxId: Int
    {
        return _monIdxId
    }
    
    var description: String
    {
        if _description == nil
        {
            _description = ""
        }
        return _description
    }
    
    var type: String
    {
        get
        {
            if _type == nil
            {
                _type = ""
            }
            return _type
        }
    }
    
    var defense: String
    {
        get
        {
            if _defense == nil
            {
                _defense = ""
            }
            return _defense
        }
    }
    
    var height: String
    {
        get
        {
            if _height == nil
            {
                _height = ""
            }
            return _height
        }
    }
    
    var weight: String
    {
        get
        {
            if _weight == nil
            {
                _weight = ""
            }
            return _weight
        }
    }
    
    var attack: String
    {
        get
        {
            if _attack == nil
            {
                _attack = ""
            }
            return _attack
        }
    }
    
    var nextEvoText: String
    {
        get
        {
            if _nextEvoText == nil
            {
                _nextEvoText = ""
            }
            return _nextEvoText
        }
    }
    
    var nextEvoId: String
    {
        get
        {
            if _nextEvoId == nil
            {
                _nextEvoId = ""
            }
            return _nextEvoId
        }
    }
    
    var nextEvoLvl: String
    {
        get
        {
            if _nextEvoLvl == nil
            {
                _nextEvoLvl = ""
            }
            return _nextEvoLvl
        }
    }
    
    var monsterUrl: String
    {
        get
        {
            if _monsterUrl == nil
            {
                _monsterUrl = ""
            }
            return _monsterUrl
        }
        
    }
    // Encapsulation >>>>>>>>>>>>>>>>>>>>>
    
    init(name: String, monIdxId: Int)
    {
        self._name = name
        self._monIdxId = monIdxId
        
        _monsterUrl = "\(URL_BASE)\(URL_MONSTER)\(self._monIdxId)/"
    }
   
    func downloadMonsterData(completed: DownloadComplete)
    {
        let url = NSURL(string: _monsterUrl)!
        Alamofire.request(.GET, url ).responseJSON { response in
            let result = response.result

            //print(result.value.debugDescription)
            
            if let dict = result.value as? Dictionary<String, AnyObject>
            {
                if let weight = dict["weight"] as? String
                {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String
                {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int
                {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int
                {
                    self._defense = "\(defense)"
                }
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0
                {
                    //print(types.debugDescription)
                    
                    if let type = types[0]["name"]
                    {
                        self._type = type.capitalizedString
                    }
                    
                    if types.count > 1
                    {
                        for x in 1 ..< types.count
                        {
                            if let name = types[x]["name"]
                            {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                }
                else
                {
                    self._type = ""
                }
                print(self._type)
                
                if let desc = dict["descriptions"] as? [Dictionary<String, String>] where desc.count > 0
                {
                    if let url = desc[0]["resource_uri"]
                    {
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                            let descResult = response.result
                            if let descDict = descResult.value as? Dictionary<String, AnyObject>
                            {
                                if let description = descDict["description"] as? String
                                {
                                    self._description = description
                                    print(self._description)
                                }
                            }
                            completed()
                        }
                       
                    }
                }
                else
                {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0
                {
                    if let to = evolutions[0]["to"] as? String
                    {
                        //there's no mega
                        if to.rangeOfString("mega") == nil
                        {
                            if let resourceUri = evolutions[0]["resource_uri"] as? String
                            {
                                let url = resourceUri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = url.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvoId = num
                                self._nextEvoText = to
                                
                                if let level = evolutions[0]["level"] as? Int
                                {
                                    self._nextEvoLvl = "\(level)"
                                }
                                
                                print(self._nextEvoId)
                                print(self._nextEvoText)
                                print(self._nextEvoLvl)
                            }
                        }
                    }
                }
            }
        }
    }
}