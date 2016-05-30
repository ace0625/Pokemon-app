//
//  MonsterDetailVC.swift
//  Pokemon-app
//
//  Created by Dan Hyunchan Kim on 5/30/16.
//  Copyright © 2016 hyunchan. All rights reserved.
//

import UIKit

class MonsterDetailVC: UIViewController {

    var monster: Pokemon!
    
    @IBOutlet weak var detailLbl: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        detailLbl.text = monster.name
        print(monster.name)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
