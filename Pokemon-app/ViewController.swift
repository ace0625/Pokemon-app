//
//  ViewController.swift
//  Pokemon-app
//
//  Created by Dan Hyunchan Kim on 5/25/16.
//  Copyright © 2016 hyunchan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate
{
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var searchedPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var searchFlag: Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //var pokeMon = Pokemon(name: "Lizard", monIdxId: 6)
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        initAudio() //get ready for music
        parseMonsterCSV()
    }
    
    
    func initAudio()
    {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let error as NSError{
            print(error.debugDescription)
        }
    }
    
    func parseMonsterCSV()
    {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            //print(rows)
            for row in rows
            {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]
                let poke = Pokemon(name: name!, monIdxId: pokeId)
                pokemon.append(poke)
                
            }
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MonsterCell", forIndexPath: indexPath) as? MonsterCell
        {
            //let mon = Pokemon(name: "Test", monIdxId: indexPath.row)
//            cell.configureCell(mon)
            
            let poke: Pokemon!
            if searchFlag
            {
                poke = searchedPokemon[indexPath.row]
            }
            else
            {
                poke = pokemon[indexPath.row]
            }
            cell.configureCell(poke)
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
    }
    
    //when selected an item
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let poke: Pokemon!
        if searchFlag
        {
            poke = searchedPokemon[indexPath.row]
        }
        else
        {
            poke = pokemon[indexPath.row]
        }
        
        performSegueWithIdentifier("MonsterDetailVC", sender: poke)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if searchFlag
        {
            return searchedPokemon.count
        }
        else
        {
            return pokemon.count
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeMake(105, 105)
    }
    
    @IBAction func musicBtnPressed(sender: UIButton!)
    {
        if musicPlayer.playing
        {
            musicPlayer.stop()
            sender.alpha = 0.2
        }
        else
        {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchBar.text == nil || searchBar.text == ""
        {
            searchFlag = false
            view.endEditing(true)
            collection.reloadData() //refresh
        }
        else
        {
            searchFlag = true
            let searchTyped = searchBar.text!.lowercaseString
            searchedPokemon = pokemon.filter({$0.name.rangeOfString(searchTyped) != nil})  //$0 grabbing out of the array
            collection.reloadData() //refresh
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        view.endEditing(true) //hide hardware keyboard
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "MonsterDetailVC"
        {
            if let detailVC = segue.destinationViewController as? MonsterDetailVC
            {
                if let poke = sender as? Pokemon
                {
                    detailVC.monster = poke
                }
            }
        }
    }
}

