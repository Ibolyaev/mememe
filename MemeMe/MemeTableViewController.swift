//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Игорь Боляев on 16.05.15.
//  Copyright (c) 2015 Igor Bolyaev. All rights reserved.
//

import Foundation
import UIKit


class MemeTableViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    var memes: [Meme]!
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        
        if !appDelegate.didLaunch {
        
            if (memes.count == 0) {
                
                //Get instance of storyboard
                var storyboard = UIStoryboard(name: "Main", bundle: nil)
                //Get instance of Editor, Remember to set an identifier in the storyboard.
                var editMeme = storyboard.instantiateViewControllerWithIdentifier("MemeEditor") as! MemeEditor
                //Present it modally.
                self.presentViewController(editMeme, animated: true, completion: nil)
                
                //make didLaunch to true after 1st lauch of the app
                appDelegate.didLaunch = true
                
                
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        tableView.reloadData()
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Grab the DetailVC from Storyboard
        let object:AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController")!
        
        let detailVC = object as! DetailViewController
        //Populate view controller with data from the selected item
        detailVC.meme = self.memes[indexPath.row]
        
        //Present the view controller using navigation
        self.navigationController!.pushViewController(detailVC, animated: true)
        
    }
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let meme = self.memes[indexPath.row]
        
        // Set the name and image
        cell.textLabel?.text = "\(meme.topText) \(meme.bottomText)"
        cell.imageView?.image = meme.memedImage
        
        
        return cell
    }
    
}

