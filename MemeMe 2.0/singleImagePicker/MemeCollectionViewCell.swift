//
//  MemeCollectionViewCell.swift
//  memeMe2.0
//
//  Created by Stu Almeleh on 12/8/15.
//  Copyright © 2015 Stu Almeleh. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    
    func setText(top: String, bottom: String){
        topLabel.text = top
        bottomLabel.text = bottom
    }
    
}