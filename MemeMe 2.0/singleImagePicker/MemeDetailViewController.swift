//
//  MemeDetailViewController.swift
//  memeMe2.0
//
//  Created by Stu Almeleh on 12/9/15.
//  Copyright © 2015 Stu Almeleh. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView!.image = meme.memedImage
        
        self.topLabel!.text = meme.topText
        self.bottomLabel!.text = meme.bottomText
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    
    
}