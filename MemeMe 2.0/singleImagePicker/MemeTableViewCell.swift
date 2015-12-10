//
//  MemeTableViewCell.swift
//  memeMe2.0
//
//  Created by Stu Almeleh on 12/10/15.
//  Copyright © 2015 Stu Almeleh. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topLabel2: UILabel!
    @IBOutlet weak var bottomLabel2: UILabel!
    @IBOutlet weak var imageView2: UIImageView!
    
    func setText(top: String, bottom: String){
        topLabel2.text = top
        bottomLabel2.text = bottom
    }
    
}