//
//  Meme.swift
//  MemeMe
//
//  Created by Игорь Боляев on 15.05.15.
//  Copyright (c) 2015 Igor Bolyaev. All rights reserved.
//

import Foundation
import UIKit

/*
2 strings representing the top and bottom text
the original image
a memed image, combining the text and the original image
*/
class Meme {
    
    var topText: String = ""
    var bottomText: String = ""
    var originalImage: UIImage
    var memedImage: UIImage
    
    
    init(topText:String,bottomText:String,originalImage:UIImage,memedImage: UIImage){
    
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    
    }
    
    
    
    
 
   
}
