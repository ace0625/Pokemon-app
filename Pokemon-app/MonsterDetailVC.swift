//
//  MonsterDetailVC.swift
//  Pokemon-app
//
//  Created by Dan Hyunchan Kim on 5/30/16.
//  Copyright © 2016 hyunchan. All rights reserved.
//

import UIKit

class MonsterDetailVC: UIViewController
{
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var monsterIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
   
    var monster: Pokemon!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        detailLbl.text = monster.name
        //print(monster.name)
        let img = UIImage(named: "\(monster.monIdxId)")
        mainImg.image = img
        currentEvoImg.image = img
        
        monster.downloadMonsterData
        {
            //This will be called after download is completed
//            print("dowmload completed")
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        descLbl.text = monster.description
        typeLbl.text = monster.type
        defenseLbl.text = monster.defense
        heightLbl.text = monster.height
        monsterIdLbl.text = "\(monster.monIdxId)"
        weightLbl.text = monster.weight
        attackLbl.text = monster.attack
        if monster.nextEvoId == ""
        {
            evoLbl.text = "There's no evolution"
            nextEvoImg.hidden = true
        }
        else
        {
            evoLbl.hidden = false
            nextEvoImg.image = UIImage(named: monster.nextEvoId)
            
            var nextEvo = "Next Evolution: \(monster.nextEvoText)"
            if monster.nextEvoLvl != ""
            {
                nextEvo += " - LVL \(monster.nextEvoLvl)"
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }



}
