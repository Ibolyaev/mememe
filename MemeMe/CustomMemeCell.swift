//
//  CustomMemeCell.swift
//  MemeMe
//
//  Created by Игорь Боляев on 16.05.15.
//  Copyright (c) 2015 Igor Bolyaev. All rights reserved.
//

import UIKit

class CustomMemeCell: UICollectionViewCell {
    
    @IBOutlet weak var upperLabel: UILabel!
    
    @IBOutlet weak var bottomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setText (upperString:String, bottomString: String){
        
        upperLabel.text = upperString
        upperLabel.textColor = UIColor.whiteColor()
        bottomLabel.text = bottomString
        bottomLabel.textColor = UIColor.whiteColor()
    }
    
}
