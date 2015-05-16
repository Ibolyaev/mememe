//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Игорь Боляев on 16.05.15.
//  Copyright (c) 2015 Igor Bolyaev. All rights reserved.
//

import Foundation
import UIKit
class DetailViewController: UIViewController  {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       
        self.imageView!.image = meme.memedImage
    }

}