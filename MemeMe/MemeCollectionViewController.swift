//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Игорь Боляев on 16.05.15.
//  Copyright (c) 2015 Igor Bolyaev. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var memes: [Meme]!
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        
    }
    
 
    override func viewDidAppear(animated: Bool) {
        collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCell",
            forIndexPath: indexPath) as! CustomMemeCell
        let meme = memes[indexPath.item]
        cell.setText(meme.topText, bottomString: meme.bottomText)
        let imageView = UIImageView(image: meme.originalImage)
        cell.backgroundView = imageView
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //Grab the DetailVC from Storyboard
        let object:AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController")!
        
        let detailVC = object as! DetailViewController
        //Populate view controller with data from the selected item
        detailVC.meme = self.memes[indexPath.row]
        
        //Present the view controller using navigation
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
    
   }