//
//  MonsterCell.swift
//  Pokemon-app
//
//  Created by Dan Hyunchan Kim on 5/25/16.
//  Copyright © 2016 hyunchan. All rights reserved.
//

import UIKit

class MonsterCell: UICollectionViewCell {
    
    @IBOutlet weak var monsterImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
//    override init(frame: CGRect)
//    {
//        super.init(frame: frame)
//    }
//    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon)
    {
        self.pokemon = pokemon
        nameLbl.text = self.pokemon.name.capitalizedString
        monsterImg.image = UIImage(named: "\(self.pokemon.monIdxId)")
    }
    
}
